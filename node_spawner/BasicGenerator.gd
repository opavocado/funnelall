extends Generator

class_name BasicGenerator

const SPAWN_TIMER = 1

func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer).(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer):
	pass

func reconfig():
	drop_timer.start(SPAWN_TIMER)

func generate():
	# Choose a random location on Path2D.
	drop_spawn_location.offset = randi()
	print(drop_spawn_location.offset)
	var drop = gold_instance()
	drop.position = drop_spawn_location.position
	return drop
