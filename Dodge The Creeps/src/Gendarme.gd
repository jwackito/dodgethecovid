class_name Gendarme
extends Person

export var vision_range: int = 1000
var _enemy_node: Node2D = null
var _is_in_pursuit: bool = false


func _init() -> void:
	default_sprite_name = "default"


func _ready() -> void: 
	_set_neutral_gesticure()
	_set_sprite_and_collision($AnimatedSprite, $Collision)


func init(new_position: Vector2, direction, _enemy: Node2D) -> Gendarme:
	self._enemy_node = _enemy
	_init_person(new_position, direction)
	return self


func _process(delta: float):
	if (_enemy_node and _enemy_node.is_inside_tree()):
		var distance: Vector2 = _enemy_node.position - self.position
		if (distance.length() < vision_range):
			if !_is_in_pursuit:
				_set_in_pursuit()
			velocity = distance.normalized() * speed
		elif _is_in_pursuit:
			_unset_in_pursuit()
	._move(delta)


func _set_in_pursuit():
	_is_in_pursuit = true
	_set_angry_gesticure()

func _unset_in_pursuit():
	_is_in_pursuit = false
	_set_neutral_gesticure()


func _set_neutral_gesticure():
	$AnimatedGesticure.animation = "none"
	$AnimatedGesticure.stop()

func _set_angry_gesticure():
	$AnimatedGesticure.animation = "angry"
	$AnimatedGesticure.play()
