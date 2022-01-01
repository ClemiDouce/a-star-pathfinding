extends Path2D

var map : TileMap
onready var sprite = $PathFollow2D/Sprite
onready var path_follow := $PathFollow2D
var SPEED := 2.0

func _ready():
	set_process(false)

func new_path(_path: PoolVector2Array):
	curve = Curve2D.new()
	for point in _path:
		curve.add_point(map.map_to_world(point))
	set_process(true)

func _process(delta: float) -> void:
	
	path_follow.offset += SPEED * delta
	
	if path_follow.offset >= 1.0:
		set_process(false)
	
#
