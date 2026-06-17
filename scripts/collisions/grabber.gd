extends Area2D

func _process(delta: float) -> void:
	if has_overlapping_bodies():
		var bods : Array = get_overlapping_bodies()
		bods[0].global_position = global_position
		bods[0].velocity = Vector2.ZERO
		bods[0].stun = 120
