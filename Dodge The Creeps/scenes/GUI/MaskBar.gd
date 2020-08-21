extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Container/Label.text = "0%"
	$TextureProgress.value = 0

func _on_Interface_update_bars(_covid, mask):
	$Container/Label.text = "%d%%"%(mask)
	$TextureProgress.value = mask
