extends Node
func _ready() -> void:
	print("yes")
	global.camshake = 40
	Engine.time_scale = 0.1
	var timer = get_tree().create_timer(0.15,true,false,true)
	await timer.timeout
	Engine.time_scale = 1.0
	queue_free()
