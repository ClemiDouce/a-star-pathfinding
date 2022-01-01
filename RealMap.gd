extends Astar_Path

onready var player := $Player
onready var line := $Line2D

var offset := 4

func _ready() -> void:
	player.map = self
	player.new_path(get_random_destination(player.global_position), false)
	player.move()

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.is_pressed()):
		# Calculer chemin du personnage
		if event.button_index == BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()
			if used_cells.has(world_to_map(mouse_pos)): # Check si case cliquée existe
				var path = search_path(player.global_position, mouse_pos)
				if path:
					player.new_path(path)
				
		# Placer obstacle
		elif event.button_index == BUTTON_RIGHT:
			var mouse_pos = get_global_mouse_position()
			if used_cells.has(world_to_map(mouse_pos)): # Check si case cliquée existe
				print("State of Player", player.moving)
				if !player.moving:
					var path = search_path(player.global_position, mouse_pos)
					if path:
						player.new_path(path, false)
	#					self.set_cellv(path[-1], 1)
						player.move()
				else:
					player.pause()
					yield(player, "stopped")
					var path = search_path(player.global_position, mouse_pos)
					if path:
						player.new_path(path, false)
	#					self.set_cellv(path[-1], 1)
						player.move()
		
		# Arreter le joueur
		elif event.button_index == BUTTON_MIDDLE:
			player.move()
			
func search_path(start: Vector2, end:Vector2) -> PoolVector2Array:
	var new_start = world_to_map(start)
	var new_end = world_to_map(end)
	return _get_path(new_start, new_end)

func get_cell_middle(cell: Vector2):
	var half_cell_size = self.cell_size / 2
	return map_to_world(cell) + half_cell_size

func get_random_cell():
	var index = rand_range(0, used_cells.size())
	var random_cell = used_cells[index]
	while self.get_cellv(used_cells[index]) == 2:
		index = rand_range(0, used_cells.size())
		random_cell = used_cells[index]
	return random_cell
	
func get_random_destination(start: Vector2):
	var rand_cell = get_random_cell()
	var start_cell = world_to_map(start)
	while rand_cell == start_cell:
		rand_cell = get_random_cell()
	var path = _get_path(start_cell, rand_cell)
	return path

func draw_path_line(path: PoolVector2Array):
	line.clear_points()
	for point in path:
		line.add_point(get_cell_middle(point))
