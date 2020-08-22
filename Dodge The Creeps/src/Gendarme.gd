class_name Gendarme
extends Person


export var vision_range: int = 1000
var _enemy_node: Node2D = null


func _init() -> void:
	default_sprite_name = "default"


func _ready() -> void: 
	_set_sprite_and_collision($AnimatedSprite, $Collision)


func init(new_position: Vector2, direction, _enemy: Node2D) -> Gendarme:
	self._enemy_node = _enemy
	_init_person(new_position, direction)
	damage = 0
	return self


func _process(delta: float):
	if (_enemy_node and _enemy_node.is_inside_tree()):
		var distance: Vector2 = _enemy_node.position - self.position
		if (distance.length() < vision_range):
			velocity = distance.normalized() * speed
	._move(delta)
