class_name LevelOne
extends Node

export (PackedScene) var PersonWithMaskPackage
onready var SpawnEnemyTimer = get_node("SpawnEnemyTimer")

func _ready():
	randomize()
	SpawnEnemyTimer.start()


func _on_SpawnEnemyTimer_timeout():
	$InitPersonPath/InitPosition.set_offset(randi()) # get random position
	var person = PersonWithMaskPackage.instance()
	var direction = $InitPersonPath/InitPosition.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	person.position = $InitPersonPath/InitPosition.position
	person.rotation = direction
	person.set_random_velocity(direction)
	add_child(person)
