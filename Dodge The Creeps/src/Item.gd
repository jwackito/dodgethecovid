class_name Item
extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(x, y) -> Item:
	position.x = x
	position.y = y
	
	return self
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
