extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal update_bars(covid, mask)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AlcoholCounter.hide()
	$CDSCounter.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Player_hit(covid, mask):
	emit_signal("update_bars", covid, mask)

func _on_Player_alcohol_hit():
	$AlcoholCounter.show()

func _on_Player_alcohol_timeout():
	$AlcoholCounter.hide()

func _on_Player_alcohol_update(value):
	$AlcoholCounter/Label.text = "%0.2f s"%(value)

func _on_Player_cds_hit():
	$CDSCounter.show()

func _on_Player_cds_timeout():
	$CDSCounter.hide()

func _on_Player_cds_update(value):
	$CDSCounter/Label.text = "%0.2f s"%(value)
