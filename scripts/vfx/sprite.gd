extends AnimatedSprite2D
func _process(delta: float) -> void:
	material.set_shader_parameter("transparency",modulate.a)
