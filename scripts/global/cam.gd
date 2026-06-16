extends Camera2D
@export var node1: Node2D
@export var node2 : Node2D
func _process(delta: float) -> void:
	position = (node1.position + node2.position) / 2
	global.camshake -= 1
	offset = clampi(global.camshake,0,20) * Vector2(randf_range(-1,1),randf_range(-1,1)) * 4
