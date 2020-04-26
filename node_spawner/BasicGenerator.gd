extends Generator

class_name BasicGenerator

const SPAWN_TIMER = 1

func get_name():
	return "BasicGenerator"

func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer).(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer):
	pass

func reconfig():
	drop_timer.start(SPAWN_TIMER)

func generate():
	# Choose a random location on Path2D.
	drop_spawn_location.offset = randi()
	var drop = gold_instance()
	drop.position = drop_spawn_location.position
	
	# Debug
	#print(drop_spawn_location.offset)
	
	return drop
