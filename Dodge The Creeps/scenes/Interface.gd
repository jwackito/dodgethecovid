extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal update_bars(covid, mask)

# Called when the node enters the scene tree for the first time.
func _ready():
	$MaskBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_hit(covid, mask):
	emit_signal("update_bars", covid, mask)
