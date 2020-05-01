extends Node


func _ready():
	$DropSpawner.start()
	$ImplosionBomb.launch()

func _process(delta):
	pass


func _on_HelperTimer_timeout():
	pass
