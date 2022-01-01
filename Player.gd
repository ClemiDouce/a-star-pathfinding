extends Sprite

onready var tween = $Tween

var map : TileMap
var path := PoolVector2Array()
var path_index = 0

var step := true
var stop := false
var moving := false

signal stopped(pos)


func _process(delta: float) -> void:
	pass

func new_path(new_path: PoolVector2Array, move_by_step=true):
	if new_path.size() > 0:
		self.path = new_path
		path_index = 0
		step = move_by_step
	
func move():
	stop = false
	if path.size() == 0:
		print("Pas de chemin")
		return
	elif path_index + 1 > path.size():
		print("Arrivé en fin de chemin")
		return
	moving = true
	if step:
		tween.interpolate_property(self, "position", self.global_position, map.map_to_world(path[path_index]), 0.5)
		tween.start()
		path_index += 1
	else:
		for point in self.path:
			if stop:
				break
			tween.interpolate_property(self, "position", self.global_position, map.map_to_world(point), 0.5)
			path.remove(0)
			path_index += 1
			tween.start()
			yield(tween, "tween_completed")
	moving = false
	emit_signal("stopped", self.global_position)
	print('Fin du chemin')
	

func stop():
	self.stop = true
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		stop()
