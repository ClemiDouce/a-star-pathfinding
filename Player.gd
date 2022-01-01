extends Sprite

onready var tween = $Tween

var map : TileMap
var path := PoolVector2Array()
var path_index = 0


func _process(delta: float) -> void:
	pass

func new_path(new_path: PoolVector2Array):
	if new_path.size() > 0:
		self.path = new_path
		path_index = 0
	
func move():
	if path.size() == 0:
		print("Pas de chemin")
		return
	elif path_index + 1 > path.size():
		print("Arrivé en fin de chemin")
		return
	
	tween.interpolate_property(self, "position", self.global_position, map.map_to_world(path[path_index]), 0.5)
	tween.start()
	path_index += 1
	

func stop():
	pass
