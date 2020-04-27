extends Generator

class_name TopGenerator

var drop_path
var drop_spawn_location

func get_name():
	return "TopGenerator"

func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer).(spawner_drop_timer):
	self.drop_path = spawner_drop_path
	self.drop_spawn_location = spawner_drop_spawn_location
