extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var apply_position = $Gold.position
	var target_position = Vector2($Gold.position.x-200, $Gold.position.y-100)
	#$Gold.apply_impulse(apply_position, target_position)
	$Gold.add_central_force(target_position)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
