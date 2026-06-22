extends Area2D

func _process(delta: float) -> void:
	if has_overlapping_bodies():
		if not get_parent().attacking and not get_parent().stun > 1 and not get_parent().dodging:
			get_parent().velocity.x += -get_parent().get_child(0).scale.x * 60
