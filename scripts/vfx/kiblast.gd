extends AnimatedSprite2D
func _ready() -> void:
	var ogscale = scale
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,0),0.2)
	tween.parallel().tween_property(self,"scale",ogscale * 2,0.2)
	await tween.finished
	queue_free()
