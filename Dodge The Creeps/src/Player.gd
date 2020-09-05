class_name Player
extends KinematicBody2D

signal alcohol_hit
signal alcohol_timeout
signal alcohol_update(value)
signal cds_hit
signal cds_timeout
signal cds_update(value)
signal end_level(covid, mask, permits)
signal gameover
signal hit(covid, mask)
signal permit_update(permits)


var screen_size
var level_size

export var alcohol_on = false
export var cds_on = false
export var covid = 0
export var mask = 0
export var permits = 0
export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	level_size = get_parent().get_parent().level_size
	alcohol_on = false

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

func _physics_process(delta):
	var velocity = get_velocity_from_input()
	if cds_on:
		velocity = -velocity
		emit_signal("cds_update",$CDSTimer.get_time_left())
	move_and_slide(velocity)
	
func _process(delta):
	var velocity = get_velocity_from_input()
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
#	position += velocity * delta
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
	if alcohol_on:
		emit_signal("alcohol_update", $AlcoholTimer.get_time_left())

func update_life(enemy):
	var coef
	if alcohol_on:
		coef = 0.1
	else:
		coef = enemy.damage.get_damage_for_player()
	covid = covid + ((100 - (.5) * mask) * coef * randf())
	mask = max(0, mask - (100 * coef * randf()))
	emit_signal("hit", covid, mask)
	if covid > 100:
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("gameover")
		queue_free()

func update_mask():
	mask =  min(100, mask + 25)
	emit_signal("hit", covid, mask)

func process_item(item):
	var type = item.type
	if type == "HCQS":
		pass
	if type == "Gel":
		$AlcoholTimer.start()
		alcohol_on = true
		emit_signal("alcohol_hit")
	if type == "CDS":
		$CDSTimer.start()
		cds_on = true
		emit_signal("cds_hit")
	if type == "Mask":
		update_mask()
	if type == "EndLevel":
		emit_signal("end_level", covid, mask, permits)
	if type == "Permit":
		permits += 1
		emit_signal("permit_update", permits)
	if type != "StartLevel":
			item.queue_free()

func _on_Player_body_entered(body):
	if body.get("damage"):
		update_life(body)
	if body.get("type"):
		process_item(body)
	if body is Gendarme:
		if permits == 0:
			position = get_parent().get_parent().start_level_position
		else:
			permits -= 1
			emit_signal("permit_update", permits)
		body.handle_collision_with_player()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func got_hit(body):
	_on_Player_body_entered(body)

func _on_AlcoholTimer_timeout():
	alcohol_on = false
	emit_signal("alcohol_timeout")

func _on_CDSTimer_timeout():
	cds_on = false
	emit_signal("cds_timeout")
