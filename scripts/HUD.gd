extends CanvasLayer


func _ready():
	hide()

func hide():
	var children = get_children()
	for node in children:
		node.hide()

func show():
	var children = get_children()
	for node in children:
		node.show()
