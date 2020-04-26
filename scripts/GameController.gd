extends Node2D

var score
var missed

func _ready():
	$HUD.hide()
	score = 0
	missed = 0
	$HUD/ScoreLabel.text = str(score)
	$HUD/MissedLabel.text = str(missed)

func _process(delta):
	$HUD/ScoreLabel.text = str(score)
	$HUD/MissedLabel.text = str(missed)

func _on_Player_node_caught():
	score += 1

func game_over():
	$NodeSpawner.stop()

func new_game():
	$HUD.show()
	$Environment.generate()
	score = 0
	missed = 0 
	$Player.start($StartPosition.position)
	$NodeSpawner.start()

func _on_Node_collided(body):
	missed += 1
	body.queue_free()
