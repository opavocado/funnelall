extends Node

class_name Generator

var Gold = load("res://Gold.tscn") # TODO see how I can load this from a config file, this will definitely come back and bite me in the ass

var drop_timer

func get_name():
	return "Generator"

func generate():
	pass

func reconfig():
	pass

func add_custom_torque(body:RigidBody2D, torque:float):
	body.add_torque(rand_range(-torque,torque))

func _init( spawner_drop_timer):
	self.drop_timer = spawner_drop_timer

func gold_instance():
	return Gold.instance()
