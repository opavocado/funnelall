extends TopGenerator

class_name TunnelGenerator

const SPAWN_TIMER = .3
const SPAWN_TORQUE = 5

const STARTING_OFFSET = 240
var previous_offset = STARTING_OFFSET
var max_offset
const STEP = 16 # aprox 1 drop
const MAX_VARIANCE = STEP * 3
var random = RandomNumberGenerator.new()

func get_name():
	return "Tunnel"

func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer).(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer):
	max_offset = drop_path.get_curve().get_baked_length()
	#print("max offset: " + str(max_offset))

func reconfig():
	drop_timer.start(SPAWN_TIMER)
	previous_offset = random.randi_range(50, 430)

func generate():
	# Choose a random location on Path2D.
	# max_variance before and after current location. Avoid current location, going below 0 and over max_offset
	var before_offset = max(0, random.randi_range(previous_offset - MAX_VARIANCE, previous_offset - STEP))
	var after_offset = min(max_offset, random.randi_range(previous_offset + STEP, previous_offset + MAX_VARIANCE))
	drop_spawn_location.offset = before_offset if randf() <= .5 else after_offset
	var drop = drop_instance()
	drop.position = drop_spawn_location.position
	previous_offset = drop_spawn_location.offset
	add_custom_torque(drop, SPAWN_TORQUE)
	# Debug
	#print("Prev: " + str(previous_offset) + " - before: " + str(before_offset) + " - after: " + str(after_offset) + " - final: " + str(drop_spawn_location.offset))
	
	return drop
