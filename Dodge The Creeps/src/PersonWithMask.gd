class_name PersonWithMask
extends Person

func _init():
	damage = 35
	__init()


func _ready():
	_set_sprite_and_collision($AnimatedSprite, $Collision)
