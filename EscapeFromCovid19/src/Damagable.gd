extends Node

class_name Damagable

export var damage: float

func _init(coef: float):
	damage = coef

func get_damage_for_player() -> float:
	return damage
