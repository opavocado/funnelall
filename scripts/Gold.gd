extends RigidBody2D

class_name Drop

func get_name():
	return "Drop"
	
func _on_Visibility_screen_exited():
	queue_free()
