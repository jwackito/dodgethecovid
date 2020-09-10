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

func _init_items(mask=25, alcohol=20, hcqs=25, cds=25, permit=5):
	entities = {
		"mask": {
			"spawn_percent": mask,
		},
		"gel_alcohol": {
			"spawn_percent": alcohol,
		},
		"hcqs": {
			"spawn_percent": hcqs,
		},
		"cds": {
			"spawn_percent": cds,
		},
		"permit": {
			"spawn_percent": permit,
		},
	}

func _init_enemies(person_wmask = 20, person_womask=20, person_sick=20, gendarme=20, police=20):
	entities = {
		"person_with_mask": {
			"spawn_percent": person_wmask,
		},
		"person_without_mask": {
			"spawn_percent": person_womask,
		},
		"person_visibly_sick": {
			"spawn_percent": person_sick,
		},
		"gendarme": {
			"spawn_percent": gendarme,
		},
		"police": {
			"spawn_percent": police,
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
