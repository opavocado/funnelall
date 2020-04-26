extends Generator

class_name TunnelGenerator

var previous_offset
var max_offset

func _init(spawner_node_path, spawner_node_spawn_location, spawner_node_timer).(spawner_node_path, spawner_node_spawn_location, spawner_node_timer):
	max_offset = 

func generate():
		# Choose a random location on Path2D.
	node_spawn_location.offset = randi()
	
	var node = gold_instance()
	
	# Set the mob's direction perpendicular to the path direction.
	#var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	
	node.position = node_spawn_location.position
	return node
	
	# Add some randomness to the direction.
	#direction += rand_range(-PI / 4, PI / 4)
	#mob.rotation = direction
	# Set the velocity (speed & direction).
	#mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	#mob.linear_velocity = mob.linear_velocity.rotated(direction)
