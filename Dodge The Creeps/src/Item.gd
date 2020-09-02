class_name Item
extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var type

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(x, y) -> Item:
	position.x = x
	position.y = y
	return self


func _on_Item_body_entered(body):
	if body.has_method("got_hit"):
			body.got_hit(self)
