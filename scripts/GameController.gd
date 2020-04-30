extends Node2D

# Collected/Missed nodes counter
var score
var missed
var recovering_progress = 0
const PENALTY_PERCENT = .6
const MISSED_DROP_POINTS = 34
const MAX_RECOVERING = 100

func _ready():
	_reset_all()

func _process(delta):
	update_missed_status(delta)
	update_HUD()

func _reset_all():
	score = 0
	missed = 0
	recovering_progress = 0
	update_HUD()

func update_HUD():
	$HUD/ScoreLabel.text = str(score)
	$HUD/MissedLabel.text = str(missed)
	$HUD/RecoveringProgressBar.value = recovering_progress
	$HUD/GeneratorLabel.text = $DropSpawner.current_generator.get_name()

func _on_Player_gold_caught():
	score += 1

func game_over():
	$DropSpawner.stop()
	$Environment.dismantle()
	$Player.position = Vector2(-32,-32) # "Hide" player - TODO refactor
	$HUD.hide()
	var penalty = score * PENALTY_PERCENT
	var total = score - missed - penalty
	$UIGameOver.set_summary(score, missed, penalty, total)
	$UIGameOver.show()


func new_game():
	_reset_all()
	$UIGameOver.hide()
	$HUD.show()
	$Environment.generate()
	$Player.start($StartPosition.position)
	$DropSpawner.start()

func _on_Drop_collided(body):
	missed += 1
	recovering_progress += MISSED_DROP_POINTS
	if(recovering_progress >= MAX_RECOVERING):
		game_over() 
	body.queue_free()

func update_missed_status(delta):
	if(recovering_progress > 0):
		if(recovering_progress < delta):
			recovering_progress = 0
		else:
			recovering_progress -= delta
