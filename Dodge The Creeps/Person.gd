class_name Person
extends RigidBody2D

export (int) var min_speed
export (int) var max_speed
export (float) var min_damage_variation

var default_sprite_name = "default"
var collision_scale = { "x": 1, "y": 1 }
var damage = 0
var velocity

func __init():
	gravity_scale = 0

func _process(delta):
	if (linear_velocity.length() < min_speed):
		set_random_velocity(linear_velocity.angle())

func _set_sprite_and_collision(AnimateSprite, Collision):
	AnimateSprite.animation = default_sprite_name
	Collision.scale.x = collision_scale.x
	Collision.scale.y = collision_scale.y

func get_damage():
	return damage * rand_range(min_damage_variation, 1)

func set_random_velocity(direction):
	if (!velocity):
		velocity = int(rand_range(min_speed, max_speed))
	var velocity_direction = Vector2(velocity, 0)
	set_linear_velocity(velocity_direction.rotated(direction))

func _on_Visibility_screen_exited():
	queue_free()
