class_name Bar
extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_TextureProgress_value_changed(value):
	$TextureProgress/Timer.start()
	$TextureProgress.texture_progress.pause = false

func _on_Timer_timeout():
	$TextureProgress.texture_progress.set_current_frame(0)
	$TextureProgress.texture_progress.pause = true
