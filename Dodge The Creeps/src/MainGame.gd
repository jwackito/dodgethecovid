extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var level
var usercovid
var usermask
# Called when the node enters the scene tree for the first time.
func _ready():
	usercovid = 0
	usermask = 0

func _on_Level_level_ended(covid, mask):
	usercovid = covid
	usermask = mask
	remove_child(level)
	$VBoxContainer.show()
	$VBoxContainer/Button.text = "Next Level"	

func _on_Button_pressed():
	level = load("scenes/LevelOne.tscn").instance()
	add_child(level)
	level.connect("level_ended", self, "_on_Level_level_ended")
	var player = level.get_node("LevelLayer/Player")
	player.covid = usercovid
	player.mask = usermask
	$VBoxContainer.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
