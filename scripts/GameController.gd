extends Node2D

# Collected/Missed nodes counter
var score
var missed
var missed_timers # used for clearing missed counter based on timers since the miss happened
const PENALTY_PERCENT = .6
const MAX_RECOVERING = 10

func _ready():
	_reset_all()

func _process(delta):
	update_HUD()

func _reset_all():
	score = 0
	missed = 0
	missed_timers = []
	update_HUD()

func update_HUD():
	$HUD/ScoreLabel.text = str(score)
	$HUD/MissedLabel.text = str(missed)
	$HUD/RecoveringLabel.text = str(missed_timers.size())
	$HUD/GeneratorLabel.text = $DropSpawner.current_generator.get_name()

func _on_Player_gold_caught():
	score += 1

func game_over():
	$DropSpawner.stop()
	$Environment.dismantle()
	$Player.position = Vector2(-1,-1) # "Hide" player - TODO refactor
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
	if(missed_timers.size() >= MAX_RECOVERING):
		game_over() 
	else:
		var timer = Timer.new()
		timer.wait_time = 30.0
		timer.one_shot = true
		timer.connect("timeout", self, "_on_Missed_Timer_timeout", [timer])
		missed_timers.append(timer)
		add_child(timer)
		timer.start()
	body.queue_free()

func _on_Missed_Timer_timeout(timer):
	missed_timers.erase(timer)
	timer.queue_free()
