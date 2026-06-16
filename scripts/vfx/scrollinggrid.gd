extends ColorRect

var t : float
var off : Vector2
func _process(delta: float) -> void:
	t+=delta
	off += Vector2(delta,delta) * 100
	material.set_shader_parameter("grid_offset",off)
