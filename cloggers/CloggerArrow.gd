extends KinematicBody2D

var moving = false

func _ready():
	moving = true

func _process(delta):
	move_and_slide(Vector2(0,10000 *delta))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
