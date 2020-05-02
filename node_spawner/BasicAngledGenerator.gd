extends TopGenerator

class_name BasicAngledGenerator

const SPAWN_TIMER = 1
const SPAWN_TORQUE = 10.0
var max_offset
var center_point

func get_name():
	return "BasicAngledGenerator"

func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer).(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer):
	max_offset = spawner_drop_path.get_curve().get_baked_length()
	center_point = Vector2(max_offset/2, 720)

func reconfig():
	drop_timer.start(SPAWN_TIMER)

# This is the Angled version of the Basic Generator
# Basically, all drops are shot faster towards the center point of the viewport.
# The closer to the edges of the screen, the faster the shot.
func generate():
	# Choose a random location on Path2D.
	drop_spawn_location.offset = rand_range(0,max_offset)
	var drop = drop_instance()
	drop.position = drop_spawn_location.position
	# Calculate force - further away from center, stronger magnitude
	var center_point_variant = Vector2(center_point.x + rand_range(-100,100), center_point.y - rand_range(50,200))
	var angle = (center_point_variant - drop.position).angle()
	var length = 50 + abs(drop.position.x - center_point.x) * 1.5
	#print(str(drop.position.x) + " " + str(center_point.x) + " " + str(length))
	var force = Vector2(length * cos(angle), length * sin(angle))
	drop.apply_central_impulse(force)
	
	# Adjusting rotation for animation purposes
	if drop.position.x > center_point_variant.x :
		drop.rotation += angle - 45
	else:
		drop.rotation -= angle - 45
	add_custom_torque(drop, SPAWN_TORQUE)
	
	# Debug
	#print(drop_spawn_location.offset)
	
	return drop
