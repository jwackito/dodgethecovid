class_name Person
extends KinematicBody2D

export var collision_scale: Vector2
export var min_speed: int
export var max_speed: int


var default_sprite_name: String = "default"
var speed: int
var velocity: Vector2


func _on_Visibility_screen_exited():
	queue_free()


func _init_person(new_position, direction):
	position = new_position
	speed = int(rand_range(min_speed, max_speed))
	velocity = Vector2(speed, 0).rotated(direction)


#func _person_process(delta):
#	if (velocity):
#		_move(delta)


func _physics_process(delta):
	var collision := move_and_collide(velocity * delta)
	if (collision):
		var reflect := collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(reflect)
		if collision.collider.has_method("got_hit"):
			collision.collider.got_hit(self)
		


func _set_sprite_and_collision(animatedSprite, collision) -> void:
	animatedSprite.animation = default_sprite_name
	collision.scale.x = collision_scale.x
	collision.scale.y = collision_scale.y


