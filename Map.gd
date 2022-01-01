extends TileMap
class_name Astar_Path

onready var astar := AStar2D.new()
onready var used_cells := get_used_cells()


func _ready() -> void:
	_add_points()
	_connect_points()

func _add_points():
	for cell in used_cells:
		astar.add_point(id(cell), cell,1.0)
		
func _connect_points() -> void:
	for cell in used_cells:
		var neighbors = [Vector2.RIGHT, Vector2.LEFT, Vector2.DOWN, Vector2.UP]
		for neighbor in neighbors:
			var next_cell = cell + neighbor
			if !is_obstacle(next_cell):
				astar.connect_points(id(cell), id(next_cell), false)
		for x in range(0,2):
			for y in range(2,4):
				var next_cell = cell + neighbors[x] + neighbors[y]
				var cell1 = cell + neighbors[x]
				var cell2 = cell + neighbors[y]
				if !is_obstacle(next_cell):
					if !is_obstacle(cell1) and !is_obstacle(cell2):
						astar.connect_points(id(cell), id(next_cell), false)

func _get_path(start, end):
	var path = astar.get_point_path(id(start), id(end))
	if path.size() > 0:
		path.remove(0)
		return path
	
func _remove_point(cell: Vector2):
	var id = id(cell)
	astar.remove_point(id)

func id(point):
	var a = point.x
	var b = point.y
	return (a+b) * (a + b + 1) / 2 + b

func is_obstacle(cell: Vector2):
	return !used_cells.has(cell) or self.get_cellv(cell) == 2
