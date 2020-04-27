extends Generator

class_name SideShooterGenerator

const SPAWN_TIMER = .5
const SPAWN_TORQUE = 5

const STARTING_OFFSET = 240
var previous_offset = STARTING_OFFSET

# Paths
var left_drop_path
var left_drop_spawn_location
var right_drop_path
var right_drop_spawn_location

# Spawn Calculations
const STEP = 16 # aprox 1 drop
var max_offset

var random = RandomNumberGenerator.new()

func get_name():
	return "SideShooter"

func _init(left_dp, left_dsl, right_dp, right_dsl, drop_timer).(drop_timer):
	self.left_drop_path = left_dp
	self.left_drop_spawn_location = left_dsl
	self.right_drop_path = right_dp
	self.right_drop_spawn_location = right_dsl
	
	# Obtain both paths lengths
	max_offset = left_drop_path.get_curve().get_baked_length()
	if(max_offset != right_drop_path.get_curve().get_baked_length()):
		# Checking that Paths have been properly configured
		push_error("Left and Right Path lengths do not match\nLeft: " + str(max_offset) + "\nRight: " + str(right_drop_path.get_curve().get_baked_length()))
		
	# Prepare Generator
		# TODO Pick one side to start: left or right
		# TODO Pick one direction: up or down

func reconfig():
	drop_timer.start(SPAWN_TIMER)
	previous_offset = random.randi_range(50, 430)

func generate():	
	# TODO Switch side
	# TODO Calculate current offset - if 0 or max_offset has been reached, invert direction
	# TODO Calculate angle & force based on current position
	# Generate Gold
	
	pass
	#drop_spawn_location.offset = 
	#var drop = gold_instance()
	#drop.position = drop_spawn_location.position
	#previous_offset = drop_spawn_location.offset
	#add_custom_torque(drop, SPAWN_TORQUE)
	# Debug
	#print("Prev: " + str(previous_offset) + " - before: " + str(before_offset) + " - after: " + str(after_offset) + " - final: " + str(drop_spawn_location.offset))
	
	#return drop
