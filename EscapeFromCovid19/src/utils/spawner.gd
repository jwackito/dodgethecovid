class_name Spawner

var entities

func _init(entity_type):
	randomize()
	match entity_type:
		"items":
			_init_items()
		"enemies":
			_init_enemies()
		_:
			printerr("unknow entity type to spawn")

func _init_items():
	entities = {
		"mask": {
			"spawn_percent": 25,
		},
		"gel_alcohol": {
			"spawn_percent": 20,
		},
		"hcqs": {
			"spawn_percent": 25,
		},
		"cds": {
			"spawn_percent": 25,
		},
		"permit": {
			"spawn_percent": 5,
		},
	}

func _init_enemies():
	entities = {
		"person_with_mask": {
			"spawn_percent": 20,
		},
		"person_without_mask": {
			"spawn_percent": 20,
		},
		"person_visibly_sick": {
			"spawn_percent": 20,
		},
		"gendarme": {
			"spawn_percent": 20,
		},
		"police": {
			"spawn_percent": 20,
		},
	}

func take():
	var chosen = null
	var base = 0
	var guess = rand_range(0, 100)
	for k in entities.keys():
		if guess < (base + entities[k].spawn_percent):
			chosen = k
			break
		else:
			base += entities[k].spawn_percent
	assert(chosen != null)
	return chosen
