class_name PersonWithMask
extends Person


func _init() -> void:
	default_sprite_name = "default"


func _ready() -> void: 
	_set_sprite_and_collision($AnimatedSprite, $Collision)


func _process(delta: float) -> void:
	_person_process(delta)


func init(new_position, direction) -> PersonWithMask:
	_init_person(new_position, direction)
	damage = .35
	return self
