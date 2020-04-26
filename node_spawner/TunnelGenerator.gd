extends Generator

class_name TunnelGenerator

const SPAWN_TIMER = .3

var previous_offset = 160
var max_offset
var step_variance = 16 # aprox 1 drop
var max_variance = step_variance * 3
var random = RandomNumberGenerator.new()


func _init(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer).(spawner_drop_path, spawner_drop_spawn_location, spawner_drop_timer):
	max_offset = drop_path.get_curve().get_baked_length()
	print("max offset: " + str(max_offset))

func reconfig():
	drop_timer.start(SPAWN_TIMER)

func generate():
	# Choose a random location on Path2D.
	# max_variance before and after current location. Avoid current location, going below 0 and over max_offset
	var before_offset = max(0, random.randi_range(previous_offset - max_variance, previous_offset - step_variance))
	var after_offset = min(max_offset, random.randi_range(previous_offset + step_variance, previous_offset + max_variance))
	drop_spawn_location.offset = before_offset if randf() <= .5 else after_offset
	var drop = gold_instance()
	drop.position = drop_spawn_location.position
	previous_offset = drop_spawn_location.offset
	
	# Debug
	#print("Prev: " + str(previous_offset) + " - before: " + str(before_offset) + " - after: " + str(after_offset) + " - final: " + str(drop_spawn_location.offset))
	
	return drop
