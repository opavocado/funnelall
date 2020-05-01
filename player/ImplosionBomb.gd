extends KinematicBody2D

# Sequence
# 1 - pulls every drop in
# 1 - freezes them on the spot

var drop_spawner
const COOLDOWN = .1
var process_cooldown = 0
var timer_call_counter = 0
var collected_drops = []
var collected_count = 0

func _ready():
	drop_spawner = find_parent("Sandbox").find_node("DropSpawner")
	$AnimatedImplosion.visible = false
	$AnimatedCollect.visible = false
	


func _process(delta):
	process_cooldown += delta
	if collected_drops.size() > 0 && process_cooldown > COOLDOWN:
		collected_drops.pop_front().queue_free()
		process_cooldown = 0


func _on_Timer_timeout():
	timer_call_counter += 1
	var drops = drop_spawner.get_drops() # TODO - it should just pull all drops in a radius
		
	if timer_call_counter == 1:
		# Pull drops
		for drop in drops:
			var distance = position - drop.position
			drop.apply_central_impulse(-drop.linear_velocity * 1.3)
			drop.apply_central_impulse(distance.normalized() * max(distance.length(),200))
		$AnimatedImplosion.visible = true
		$AnimatedImplosion.frame = 0 # TODO remove for final implementation
		$AnimatedImplosion.playing = true
	elif timer_call_counter == 2: #&& timer_call_counter <= 5:
		# Cancel all forces in drops
		for drop in drops:
			drop.apply_central_impulse(-drop.linear_velocity)
			drop.apply_central_impulse(Vector2(0,-100))
		$AnimatedImplosion.visible = false
		$AnimatedCollect.visible = true
		$AnimatedCollect.frame = 0 # TODO remove for final implementation
		$AnimatedCollect.playing = true
		var objects = $Area2D.get_overlapping_bodies()
		for object in objects:
			if object.get_name() == "Drop":
				collected_drops.append(object)
		collected_count = collected_drops.size()
	else:
		# TODO remove for final implementation
		$AnimatedCollect.visible = false
		$Timer.stop() 
		timer_call_counter = 0

func animate_implosion():
	pass
