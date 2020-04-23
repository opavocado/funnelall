extends Node

export (PackedScene) var Node
var score
var missed

func _ready():
	randomize()
	score = 0
	missed = 0
	$ScoreLabel.text = str(score)
	$MissedLabel.text = str(missed)


func _process(delta):
	$ScoreLabel.text = str(score)
	$MissedLabel.text = str(missed)


func _on_Player_node_caught():
	score += 1


func game_over():
	$NodeTimer.stop()


func new_game():
	score = 0
	missed = 0 
	$Player.start($StartPosition.position)
	$StartButton.hide()
	$NodeTimer.start()


func _on_Start_pressed():
	new_game()


func _on_NodeTimer_timeout():
	# Choose a random location on Path2D.
	$NodePath/NodeSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var node = Node.instance()
	add_child(node)
	# Set the mob's direction perpendicular to the path direction.
	#var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	node.position = $NodePath/NodeSpawnLocation.position
	# Add some randomness to the direction.
	#direction += rand_range(-PI / 4, PI / 4)
	#mob.rotation = direction
	# Set the velocity (speed & direction).
	#mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	#mob.linear_velocity = mob.linear_velocity.rotated(direction)


func _on_Floor_body_entered(body):
	body.queue_free()
	missed += 1
