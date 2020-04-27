extends Generator

class_name SideShooterGenerator

const SPAWN_TIMER = .5
const SPAWN_TORQUE = 5

# Paths
var left_drop_path
var left_drop_spawn_location
var right_drop_path
var right_drop_spawn_location

# Spawn Calculations
enum Directions {UP, DOWN}
enum Sides {LEFT, RIGHT}
const STEP = 16 # aprox 1 drop
var max_offset
var previous_offset
var current_direction
var current_side

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

func reconfig():
	drop_timer.start(SPAWN_TIMER)
	
	# Prepare Generator #
	# Pick one side to start: left or right
	current_side = Sides.LEFT if randf() < .5 else Sides.RIGHT
	
	# Pick one direction: up or down
	current_direction = Directions.UP if randf() < .5 else Directions.DOWN
	
	# Set initial offset based on direction
	previous_offset = 0 if current_direction == Directions.UP else max_offset

func generate():
	# This is Side By Side Implementation of the Side Shooter
	# Switch side
	current_side = Sides.LEFT if current_side == Sides.RIGHT else Sides.RIGHT
	
	var current_offset = previous_offset
	# Check if end of the path has been reached and invert directions
	if previous_offset < 0:
		current_direction = Directions.UP
		current_offset = 0
	elif previous_offset > max_offset:
		current_direction = Directions.DOWN
		current_offset = max_offset
	
	# Calculate current offset 
	if current_direction == Directions.UP:
		current_offset += STEP
	else:
		current_offset -= STEP
	
	# Update offsets
	previous_offset = current_offset
	left_drop_spawn_location.offset = current_offset
	right_drop_spawn_location.offset = current_offset
	
	# Generate Gold
	var drop = gold_instance()

	# Set position and launch force
	var x_force = rand_range(60.0,90.0)
	var y_force = rand_range(-100,-140)
	if current_side == Sides.LEFT :
		drop.position = left_drop_spawn_location.position
		drop.rotation = 270
		#drop.add_central_force(Vector2(10,-65))
		#drop.apply_impulse(Vector2(240,200),Vector2(10,-10))
		drop.apply_impulse(Vector2(0,0),Vector2(x_force,y_force))
	else:
		drop.position = right_drop_spawn_location.position
		drop.rotation = 90
		#drop.add_central_force(Vector2(-10,-65))
		#drop.apply_impulse(Vector2(240,200),Vector2(-10,-10))
		drop.apply_impulse(Vector2(0,0),Vector2(-x_force,y_force))
	
	#add_custom_torque(drop, SPAWN_TORQUE)
	# Debug
	#print("Prev: " + str(previous_offset) + " - before: " + str(before_offset) + " - after: " + str(after_offset) + " - final: " + str(drop_spawn_location.offset))
	
	return drop
