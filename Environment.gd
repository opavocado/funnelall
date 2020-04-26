extends Node

export (PackedScene) var Floor
signal node_collided

func generate():
	var env_floor = Floor.instance()
	add_child(env_floor)
	env_floor.connect("node_collided", self, "on_Node_collided")

func dismantle():
	var children = get_children() 
	for child in children:
		child.queue_free()

func on_Node_collided(body):
	emit_signal("node_collided", body)
