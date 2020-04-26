extends Area2D

signal node_collided


func _on_Floor_body_entered(body):
	emit_signal("node_collided", body)
