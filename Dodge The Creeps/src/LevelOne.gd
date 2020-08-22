class_name LevelOne
extends Node

export (PackedScene) var PersonWithMaskPackage
export (PackedScene) var PersonWithoutMaskPackage
export (PackedScene) var PersonVisiblySickPackage
export (PackedScene) var GendarmePackage
export (PackedScene) var PolicePackage
onready var SpawnEnemyTimer = get_node("SpawnEnemyTimer")

export (PackedScene) var MaskPackage
export (PackedScene) var CDSPackage
export (PackedScene) var HCQSPackage
export (PackedScene) var GelAlcoholPackage
onready var SpawnItemTimer = get_node("SpawnItemTimer")

const enemies = {
	"person_with_mask": {
		"spawn_percent": 40,
	},
	"person_without_mask": {
		"spawn_percent": 60,
	},
	"person_visibly_sick": {
		"spawn_percent": 80,
	},
	"gendarme": {
		"spawn_percent": 100,
	},
	"police": {
		"spawn_percent": 0,
	},
}
var size
func _ready():
	size = get_viewport().size
	randomize()
	$LevelLayer/SpawnEnemyTimer.start()
	$LevelLayer/SpawnItemTimer.start()


func _create_militia(Militia):
	$LevelLayer/InitPersonPath/InitPosition.set_offset(randi())
	var direction = $LevelLayer/InitPersonPath/InitPosition.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	var gendarme_position: Vector2 = $LevelLayer/InitPersonPath/InitPosition.position
	var gendarme = Militia.instance().init(gendarme_position, direction, $LevelLayer/Player)
	add_child(gendarme)


func _create_civil(Civil):
	$LevelLayer/InitPersonPath/InitPosition.set_offset(randi()) # get random position
	var direction = $LevelLayer/InitPersonPath/InitPosition.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	var new_person_position = $LevelLayer/InitPersonPath/InitPosition.position
	var person = Civil.instance().init(new_person_position, direction)
	add_child(person)

func _on_SpawnEnemyTimer_timeout():
	var random_number = rand_range(0, 100)
	if random_number < enemies.person_with_mask.spawn_percent:
		_create_civil(PersonWithMaskPackage)
	elif random_number < enemies.person_without_mask.spawn_percent:
		_create_civil(PersonWithoutMaskPackage)
	elif random_number < enemies.person_visibly_sick.spawn_percent:
		_create_civil(PersonVisiblySickPackage)
	elif random_number < enemies.police.spawn_percent:
		_create_militia(PolicePackage)
	elif random_number < enemies.gendarme.spawn_percent:
		_create_militia(GendarmePackage)

func _spaw_item(Item):
	var item = Item.instance()
	item.position.x = randi()%int(size.x)
	item.position.y = randi()%int(size.y)
	add_child(item)

func _on_SpawnItemTimer_timeout():
	var items = [MaskPackage, GelAlcoholPackage, HCQSPackage, CDSPackage]
	_spaw_item(items[randi()%4])
