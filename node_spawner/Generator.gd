extends Node

class_name Generator

var Gold = load("res://Gold.tscn") # TODO see how I can load this from a config file, this will definitely come back and bite me in the ass

var drop_path
var drop_spawn_location
var drop_timer

func generate():
	pass

func reconfig():
	pass

func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer):
	self.drop_path = spawner_drop_path
	self.drop_spawn_location = spawner_drop_spawn_location
	self.drop_timer = spawner_drop_timer

func gold_instance():
	return Gold.instance()
