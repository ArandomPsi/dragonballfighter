extends ColorRect
@export var camera : Camera2D

func _process(delta: float) -> void:
	var off : Vector2 = camera.global_position * 0.2
	material.set_shader_parameter("offset",off)
