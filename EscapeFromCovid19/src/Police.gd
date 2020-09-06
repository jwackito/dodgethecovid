class_name Police
extends Person


export var vision_range: int = 1000
var _enemy_node: Node2D = null
var _is_in_pursuit = false

func _init() -> void:
	default_sprite_name = "default"


func _ready() -> void: 
	_set_sprite_and_collision($AnimatedSprite, $Collision)


func init(new_position: Vector2, direction, _enemy: Node2D) -> Police:
	self._enemy_node = _enemy
	_init_person(new_position, direction)
	return self

func handle_collision_with_player() -> void:
	_is_in_pursuit = false
