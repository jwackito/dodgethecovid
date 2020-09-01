class_name LevelOne
extends Node

export (PackedScene) var MaskPackage
export (PackedScene) var CDSPackage
export (PackedScene) var HCQSPackage
export (PackedScene) var GelAlcoholPackage
export (PackedScene) var PermitPackage

export (PackedScene) var StartLevel
export (PackedScene) var EndLevel

export (PackedScene) var PersonWithMaskPackage
export (PackedScene) var PersonWithoutMaskPackage
export (PackedScene) var PersonVisiblySickPackage
export (PackedScene) var GendarmePackage
export (PackedScene) var PolicePackage

export var level_size = Vector2(5000,3500)
export var start_level_position = Vector2(0, 0)
export var end_level_position = Vector2(5000, 3500)

signal level_ended(covid, mask, permits)

var RandomGen = preload("utils/random_points_surface.gd")
var Spawner   = preload("utils/spawner.gd")

var items;
var enemies;

var items_positions = RandomPointsSurface.new(level_size.x, level_size.y, 500, 500)
var items_spawner   = Spawner.new("items")
var enemies_spawner = Spawner.new("enemies")

func _ready():
	items = { "mask": MaskPackage, "gel_alcohol": GelAlcoholPackage, "hcqs": HCQSPackage, "cds": CDSPackage, "permit": PermitPackage }
	randomize()
	$LevelLayer/SpawnEnemyTimer.start()
	$LevelLayer/SpawnItemTimer.start()
	_spawn_start_end_level()

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
	match enemies_spawner.take():
		"person_with_mask":
		  _create_civil(PersonWithMaskPackage)
		"person_without_mask":
		  _create_civil(PersonWithoutMaskPackage)
		"person_visibly_sick":
		  _create_civil(PersonVisiblySickPackage)
		#"police":
		#  _create_militia(PolicePackage)
		"gendarme":
		  _create_militia(GendarmePackage)

func _spaw_item(Item):
	var item = Item.instance()
	var new_item_position = items_positions.take()
	item.position.x = new_item_position[0]
	item.position.y = new_item_position[1]
	add_child(item)

func _spawn_start_end_level():
	var start = StartLevel.instance()
	var end = EndLevel.instance()
	start.position = start_level_position
	end.position = end_level_position
	add_child(start)
	add_child(end)
	$LevelLayer/Player.position = start_level_position

func _on_SpawnItemTimer_timeout():
	_spaw_item(items[items_spawner.take()])

func _on_Player_end_level(covid, mask, permits):
	emit_signal("level_ended", covid, mask, permits)
	#$LevelLayer/Player.queue_free()
