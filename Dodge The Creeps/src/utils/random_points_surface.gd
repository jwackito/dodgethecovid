class_name RandomPointsSurface

var stock = []
var x
var y
var cellsize_x
var cellsize_y

func _init(xx, yy, ccellsize_x = 100, ccellsize_y = 100):
	x = xx
	y = yy
	cellsize_x = ccellsize_x
	cellsize_y = ccellsize_y
	randomize()
	refill()

func take():
	if stock.size() == 0:
		refill()
	var elem = stock.pop_back()
	elem[0] = elem[0] + (randi() % cellsize_x)
	elem[1] = elem[1] + (randi() % cellsize_y)
	return elem

func refill():
	for i in range(0, x, cellsize_x):
		for j in range(0, y, cellsize_y):
			stock.append([i,j])
	stock.shuffle()
