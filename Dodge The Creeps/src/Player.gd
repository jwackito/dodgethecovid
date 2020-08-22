class_name Player
extends Area2D

signal hit(covid, mask)

var screen_size
var level_size

export var speed = 400
export var covid  = 0
export var mask  = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	level_size = Vector2(3000, 3000)

func get_velocity_from_input():
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	return velocity.normalized() * speed

func _process(delta):
	var velocity = get_velocity_from_input()
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, level_size.x)
	position.y = clamp(position.y, 0, level_size.y)
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	if velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = velocity.y > 0

func update_life(enemy):
	var coef = enemy.damage.get_damage_for_player()
	covid = covid + ((100 - (.5) * mask) * coef * randf())
	mask = max(0, mask - (100 * coef * randf()))
	emit_signal("hit", covid, mask)
	print(covid, mask)
	if covid > 100:
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
	
func _on_Player_body_entered(body):
	if body.get("damage"):
		update_life(body)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
