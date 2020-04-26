extends Node



func _ready():
	randomize()

func _on_Menu_start_game():
	$Menu.hide()
	$GameController.new_game()
