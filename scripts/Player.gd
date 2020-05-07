extends Area2D

signal drop_caught

var Implosion_Bomb = load("res://player/ImplosionBomb.tscn")
const IMPLOSION_BOMB_COOLDOWN = 5
var item_last_use = IMPLOSION_BOMB_COOLDOWN
var game_controller

export var speed = 350
var screen_size

func _ready():
	game_controller = get_parent()
	item_last_use = IMPLOSION_BOMB_COOLDOWN
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	item_last_use = min(item_last_use + delta, 600) # hard capping max CD count to 10 min (want to avoid max float)
	_process_movement(delta)
	_process_items(delta)


func _on_Player_body_entered(body):
	if body.get_name() == "Drop":
		body.queue_free() # Caught drop is deleted
	emit_signal("drop_caught",1)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _process_movement(delta):
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
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0

func _process_items(delta):
	if Input.is_action_pressed("ui_accept") && IMPLOSION_BOMB_COOLDOWN < item_last_use:
		var implosion_bomb = Implosion_Bomb.instance()
		game_controller.add_child(implosion_bomb)
		implosion_bomb.launch(self.position)
		implosion_bomb.connect("item_destroyed",self,"_on_item_caught_drop")
		item_last_use = 0

func _on_item_caught_drop(quantity_caught):
	emit_signal("drop_caught",quantity_caught)

func restart():
	self.position = Vector2(-32,-32) # "Hide" player - TODO refactor
