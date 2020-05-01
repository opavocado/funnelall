extends RigidBody2D

# Sequence
# 1 - pulls every drop in
# 2 - collects them

signal collected_drops

const _PROCESS_COOLDOWN = .1 # used internally for collecting drops
var process_cooldown = 0
var collected_drops = []
var collected_count = 0

enum States {TRAVELING, PULLING, COLLECTING, DESTROYING}
var current_state

func _ready():
	$AnimatedImplosion.visible = false
	$AnimatedCollect.visible = false
	$Timer.stop()

func launch(initial_position):
	self.position = initial_position
	$Timer.start()
	current_state = States.TRAVELING
	self.apply_central_impulse(Vector2(0,-300))

func _process(delta):
	process_cooldown += delta
	if collected_drops.size() > 0 && process_cooldown > _PROCESS_COOLDOWN:
		var ref_drop = weakref(collected_drops.pop_front()).get_ref()
		if ref_drop:
			ref_drop.queue_free()
		process_cooldown = 0


func _on_Timer_timeout():
	transition_state() # Every timer timeout forces a transition in the ImplosionBomb's state
	var drops
	if current_state == States.PULLING:
		# Pull drops
		drops = obtain_drops_in_area($PullArea)
		for drop in drops:
			var distance = position - drop.position
			drop.apply_central_impulse(-drop.linear_velocity * 1.3)
			drop.apply_central_impulse(distance.normalized() * max(distance.length(),200))
		$AnimatedImplosion.visible = true
		$AnimatedImplosion.playing = true
	elif current_state == States.COLLECTING:
		# Collect all forces in drops
		drops = obtain_drops_in_area($CollectArea)
		for drop in drops:
			drop.apply_central_impulse(-drop.linear_velocity)
			drop.apply_central_impulse(Vector2(0,-100))
		collected_drops = obtain_drops_in_area($CollectArea)
		collected_count = collected_drops.size()		
		$AnimatedCollect.visible = true
		$AnimatedCollect.playing = true
	elif current_state == States.DESTROYING:
		emit_signal("collected_drops",collected_count)
		queue_free()

func obtain_drops_in_area(area:Area2D):
	var drops = []
	var objects = area.get_overlapping_bodies()
	for object in objects:
		if object.get_name() == "Drop":
			drops.append(object)
	return drops

func transition_state():
	if current_state == States.TRAVELING:
		current_state = States.PULLING
		self.mode = MODE_STATIC
		#self.apply_central_impulse(-self.linear_velocity)
		#self.gravity_scale = 0.1
	elif current_state == States.PULLING:
		current_state = States.COLLECTING
	elif current_state == States.COLLECTING:
		current_state = States.DESTROYING

func _on_CollisionArea_body_entered(body):
	if body.get_name() == "Drop":
		collected_count += 1
		body.queue_free()


func _on_AnimatedCollect_animation_finished():
	$AnimatedCollect.visible = false


func _on_AnimatedImplosion_animation_finished():
	$AnimatedImplosion.visible = false

func get_name():
	return "ImplosionBomb"
