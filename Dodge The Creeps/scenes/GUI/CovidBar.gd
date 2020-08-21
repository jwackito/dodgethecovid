extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/Label.text = "0%"
	$TextureProgress.value = 0

func _on_Interface_update_bars(covid, _mask):
	$Container/Label.text = "%d%%"%(covid)
	$TextureProgress.value = covid
