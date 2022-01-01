extends Astar_Path

onready var player := $Player
onready var line := $Line2D

func _ready() -> void:
	player.map = self

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.is_pressed()):
		# Calculer chemin du personnage
		if event.button_index == BUTTON_LEFT:
			var mouse_pos = get_global_mouse_position()
			if used_cells.has(world_to_map(mouse_pos)): # Check si case cliquée existe
				var path = search_path(player.global_position, mouse_pos)
				if path:
					player.new_path(path)
#					self.set_cellv(path[-1], 1)
					draw_path_line(path)
				
		# Placer obstacle
		elif event.button_index == BUTTON_RIGHT:
			var mouse_pos = world_to_map(get_global_mouse_position())
			if used_cells.has(mouse_pos):
				self.set_cellv(mouse_pos, 2)
				self._remove_point(mouse_pos)
				if player.path.size() > 0:
					search_path(player.global_position, player.path[-1])
		
		# Arreter le joueur
		elif event.button_index == BUTTON_MIDDLE:
			player.move()
			
func search_path(start: Vector2, end:Vector2) -> PoolVector2Array:
	var new_start = world_to_map(start)
	var new_end = world_to_map(end)
	return _get_path(new_start, new_end)

func draw_path_line(path: PoolVector2Array):
	line.clear_points()
	for point in path:
		line.add_point(get_cell_middle(point))

func get_cell_middle(cell: Vector2):
	var half_cell_size = self.cell_size / 2
	return map_to_world(cell) + half_cell_size
