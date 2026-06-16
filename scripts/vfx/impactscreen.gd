extends ColorRect

func _process(delta: float) -> void:
	visible = global.impactframes >= 1
