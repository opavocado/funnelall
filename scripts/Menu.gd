extends CanvasLayer

signal start_game

func _on_StartButton_pressed():
	emit_signal("start_game")

func hide():
	$MainMenu.hide()

func show():
	$MainMenu.show()
