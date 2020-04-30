extends KinematicBody2D

# Sequence
# 1 - pulls every drop in
# 1 - freezes them on the spot

var drop_spawner
var timer_call_counter = 0
var acum = 0

func _ready():
	drop_spawner = find_parent("Sandbox").find_node("DropSpawner")


func _process(delta):
	# delete this
	acum += delta
	if(acum > 5 && acum < 5.3):
		$Timer.start()


func _on_Timer_timeout():
	timer_call_counter += 1
	print(timer_call_counter)
	var drops = drop_spawner.get_drops() # TODO - it should just pull all drops in a radius
		
	if timer_call_counter == 1:
		# Pull drops
		for drop in drops:
			var distance = position - drop.position
			drop.apply_central_impulse(-drop.linear_velocity * 1.3)
			drop.apply_central_impulse(distance.normalized() * max(distance.length(),200))
	if timer_call_counter == 2:
		# Cancel all forces in drops
		for drop in drops:
			drop.apply_central_impulse(-drop.linear_velocity * 1.3)
		$Timer.stop()
