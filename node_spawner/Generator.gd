extends Node

class_name Generator

var Gold = load("res://Gold.tscn") # TODO see how I can load this from a config file, this will definitely come back and bite me in the ass

var node_path
var node_spawn_location
var node_timer

func generate():
	pass

func _init(spawner_node_path, spawner_node_spawn_location, spawner_node_timer):
	self.node_path = spawner_node_path
	self.node_spawn_location = spawner_node_spawn_location
	self.node_timer = spawner_node_timer

func gold_instance():
	return Gold.instance()
