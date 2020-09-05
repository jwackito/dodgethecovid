extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# ######################
# Difficulty:
#   * "Im not in a risk group": covid resets, permits at least 1, mask at least 50%, 1 level retry per level
#   * "Resfriadinho":  covid resets, 1 level
#   * "Im legend": whatever you got in a level, is what you get in the next, no retrys
# ######################
var difficulty
var level
var usercovid
var userpermits
var usermask
var level_retrys
var level_number
var is_retry
var hints_resources = [
	{"label": "Gel Alcohol protects you,\n\t but it doesn't make you inmune.",
	 "texture": "res://assets/art/GelAlcohol.png"},
	 {"label": "Masked people is less contagious...",
	 "texture": "res://assets/art/person/with_mask.png"}, 
	 {"label": "People without masks is more contagious...",
	 "texture": "res://assets/art/person/without_mask.png"}, 
	 {"label": "This person looks really sick\n\t stay away from them...",
	 "texture": "res://assets/art/person/visibly_sick.png"}, 
	 {"label": "Police will take you back home\n\t unless you have a permit",
	 "texture": "res://assets/art/permit.png"}, 
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	usercovid = 0
	usermask = 0
	userpermits = 0
	level_retrys = 1
	level_number = 0
	is_retry = false
	$VBoxContainer/DifficultyContainer/Difficulty.add_item("I'm not in a risk group")
	$VBoxContainer/DifficultyContainer/Difficulty.add_item("Resfriadinho")
	$VBoxContainer/DifficultyContainer/Difficulty.add_item("I'm Legend")
	$VBoxContainer/DifficultyContainer/Difficulty.select(1)

func _on_Player_level_ended(covid, mask, permits):
	usercovid = covid
	usermask = mask
	userpermits = permits
	if difficulty == 0:
		usermask = max(50, mask)
		userpermits = max(1, permits)
		level_retrys = 1
	if difficulty <= 1:
		usercovid = 0
		
func _on_Level_level_ended(_covid, _mask, _permits):
	remove_child(level)
	$VBoxContainer.show()
	$VBoxContainer/Title.text = "Get Ready!"
	$VBoxContainer/Start.text = "Next Level"
	$VBoxContainer/DifficultyContainer.hide()
	is_retry = false

func _on_Player_gameovered():
	remove_child(level)
	if level_retrys == 0:
		$VBoxContainer.show()
		$VBoxContainer/Title.text = "Game Over"
		$VBoxContainer/Start.text = "New Game"
		$VBoxContainer/DifficultyContainer.show()
	else:
		level_retrys -= 1
		is_retry = true
		_on_Start_pressed()

func show_hint(label, sprite):
	$VBoxContainer.hide()
	if not is_retry:
		$HintContainer/Label.text = label.text
		$HintContainer/Sprite.texture = sprite.texture
	else:
		var dict = hints_resources[randi()%len(hints_resources)]
		$HintContainer/Label.text = dict["label"]
		$HintContainer/Sprite.texture = load(dict["texture"])
	$HintContainer.show()
	

func _on_Start_pressed():
	level_number += 1
	level = load("scenes/LevelOne.tscn").instance()
	level.connect("level_ended", self, "_on_Level_level_ended")
	show_hint(level.get_node("ObjectiveLabel"), level.get_node("ObjectiveSprite"))
	$HintTimer.start()

func _on_Difficulty_item_selected(index):
	usercovid = 0
	usermask = 0
	userpermits = 0
	if index == 0:
		level_retrys = 3
	if index == 1:
		 level_retrys = 1
	if index == 2:
		level_retrys = 0


func _on_HintTimer_timeout():
	$HintContainer.hide()
	add_child(level)
	difficulty = $VBoxContainer/DifficultyContainer/Difficulty.get_selected_id()
	if difficulty == 0:
		usermask = max(50, usermask)
		userpermits = max(1, userpermits)
	var player = level.get_node("LevelLayer/Player")
	player.covid = usercovid
	player.mask = usermask
	player.permits = userpermits
	player.connect("end_level", self, "_on_Player_level_ended")
	player.connect("gameover", self, "_on_Player_gameovered")
	player.emit_signal("hit", usercovid, usermask)
	player.emit_signal("permit_update", userpermits)
