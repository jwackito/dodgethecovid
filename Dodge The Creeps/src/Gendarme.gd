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
	return self


func _move(delta: float) -> void:
	if (_enemy_node and _enemy_node.is_inside_tree()):
		var distance_vector: Vector2 = _enemy_node.position - self.position
		if (distance_vector.length() < vision_range):
			var movement: Vector2 = distance_vector.normalized() * speed * delta
			var collision = move_and_collide(movement)
			if collision:
				var reflect: Vector2 = collision.remainder.bounce(collision.normal)
				move_and_collide(reflect)
