extends Node

var generators = [] # Lists all existing generators
var available_generators = [] # Lists all generators that can be picked randomly
var current_generator
var random = RandomNumberGenerator.new()


func _ready():
	# Prepare Generators
	var basic_generator = BasicGenerator.new($DropPath,$DropPath/DropSpawnLocation, $DropTimer)
	generators.append(TunnelGenerator.new($DropPath,$DropPath/DropSpawnLocation, $DropTimer))
	generators.append(SideShooterGenerator.new($LeftDropPath, $LeftDropPath/LeftDropSpawnLocation, $RightDropPath, $RightDropPath/RightDropSpawnLocation, $DropTimer))
	
	# Prepare first run of the startin generator
	generators.append(basic_generator)
	available_generators.append(basic_generator)
	current_generator = basic_generator

func start():
	_destroy_all_drops()
	$AlgorithmTimer.start()
	$DropTimer.start()

func stop():
	$AlgorithmTimer.stop()
	$DropTimer.stop()

func _on_DropTimer_timeout():
	var drop = current_generator.generate()
	add_child(drop)

func _on_AlgorithmTimer_timeout():
	# Pick randomly next generator and include new generator to the available generators list
	# generators -> all implemented generators
	# available_generators -> all generators that have been made available through this process (starts with BasicGenerator only)
	# candidate_generators -> all remaining generators to be made available
	# current_generator -> currently used generator
	var next_generator
	# Check whether there are remaining generators to make available
	if generators.size() > available_generators.size():
		var candidate_generators = []
		for generator in generators:
			if !available_generators.has(generator):
				candidate_generators.append(generator)
		# Pick next generator randomly of the candidate generators
		next_generator = candidate_generators[random.randi_range(0,candidate_generators.size()-1)]
		available_generators.append(next_generator)
		current_generator = next_generator
	elif available_generators.size() > 1:
		# All generators are available, let's change the current generator to another one
		var candidate_generators = available_generators.duplicate()
		candidate_generators.erase(current_generator)
		current_generator = candidate_generators[random.randi_range(0,candidate_generators.size()-1)]
	# Finally initialize current generator
	current_generator.reconfig()
	
	# Provide a brief pause between generator switch so that drops from the new pattern would collide with existing ones
	$AlgorithmPauseSwitchTimer.start()
	$DropTimer.stop()

func _on_AlgorithmPauseSwitchTimer_timeout():
	# Resume spawning drops
	$DropTimer.start() 

func _destroy_all_drops():
	# Destroy all falling nodes
	var children = get_children()
	for child in children:
		if(child.get_name() == "Drop"):
			child.queue_free()

func get_drops():
	var drops = []
	var children = get_children()
	for child in children:
		if(child.get_name() == "Drop"):
			drops.append(child)
	return drops



