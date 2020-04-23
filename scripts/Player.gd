extends Area2D

signal node_caught

export var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
#	if Input.is_action_pressed("ui_down"):
		# Captured, but does nothing for now
#	if Input.is_action_pressed("ui_up"):
		# Captured, but does nothing for now
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Update player's position
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	
	# Animate
	## TODO
	
	#


func _on_Player_body_entered(body):
	# TODO Check what type the body is and signal accordingly
	# For now, just a generic 'node_caught' signal is emitted
	body.queue_free() # Caught node is deleted
	emit_signal("node_caught")

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

