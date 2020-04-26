extends Node2D

# Collected/Missed nodes counter
var score
var missed
var missed_timers # used for clearing missed counter based on timers since the miss happened

func _ready():
	$HUD.hide()
	score = 0
	missed = 0
	missed_timers = []
	update_HUD()

func _process(delta):
	update_HUD()

func update_HUD():
	$HUD/ScoreLabel.text = str(score)
	$HUD/MissedLabel.text = str(missed)
	$HUD/RecoveringLabel.text = str(missed_timers.size())

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
	if(missed_timers.size() >= 2):
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
