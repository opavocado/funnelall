extends Node

var generators = [] # Lists all existing generators
var available_generators = [] # Lists all generators that can be picked randomly
var current_generator


func _ready():
	# Prepare Generators
	var basic_generator = BasicGenerator.new($NodePath,$NodePath/NodeSpawnLocation, $NodeTimer)
	generators.append(basic_generator)
	available_generators.append(basic_generator)
	current_generator = basic_generator
	pass

func start():
	$AlgorithmTimer.start()
	$NodeTimer.start()

func stop():
	$AlgorithmTimer.stop()
	$NodeTimer.stop()
	
	# Destroy all falling nodes
	var children = get_children()
	for child in children:
		child.queue_free()
	
	
func _on_NodeTimer_timeout():
	var node = current_generator.generate()
	add_child(node)

func _on_AlgorithmTimer_timeout():
	# Pick randomly next generator
	# Obtain list of generators, prepare candidate algorithms list
	# Based on amount of times algorithms were changed, add new generators to the candidate algorithms list
	# Remove current one from the candidate algorithms list
	# Pick next generator randomly, if a new one was added try just going with it first
	pass
