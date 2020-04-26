extends Node

export (PackedScene) var Node

func start():
	$NodeTimer.start()

func stop():
	$NodeTimer.stop()
	
	# Destroy all falling nodes
	var children = get_children()
	for child in children:
		child.queue_free()
	
	
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
