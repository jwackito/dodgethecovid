class_name PersonWithoutMask
extends Person

func _init() -> void:
	default_sprite_name = "default"


func _ready() -> void: 
	_set_sprite_and_collision($AnimatedSprite, $Collision)


func init(new_position, direction) -> PersonWithoutMask:
	_init_person(new_position, direction)
	return self
