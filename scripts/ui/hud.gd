extends CanvasLayer

var messages : Array = ["3", "2", "1", "go"]

func _ready() -> void:
	for i in range(4):
		var tween = create_tween()
		tween.tween_property($countdown,"rotation_degrees",360,0.8).set_trans(Tween.TRANS_BACK)
		tween.parallel().tween_property($countdown,"scale",Vector2(1.5,1.5),0.1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property($countdown,"scale",Vector2(1,1),0.1).set_trans(Tween.TRANS_CUBIC)
		
		var timer = get_tree().create_timer(0.3)
		await timer.timeout
		global.camshake = 8
		$countdown.text = messages[i]
		
		await tween.finished
		$countdown.rotation = 0
	$countdown.visible = false

func _process(delta: float) -> void:
	if not $p1.text == str(global.p2combo):
		$p1.text = str(global.p2combo)
		$p1.scale = Vector2(2,2)
	if not $p2.text == str(global.p1combo):
		$p2.text = str(global.p1combo)
		$p2.scale = Vector2(2,2)
	$p1.scale = lerp($p1.scale,Vector2(1,1),0.1)
	$p2.scale = lerp($p2.scale,Vector2(1,1),0.1)


func mogged():
	$mogged.visible = true
	$mogged.scale = Vector2(5,5)
	$mogged.modulate.a = 0
	
	var tween = create_tween()
	tween.tween_property($mogged,"scale",Vector2(1,1),0.8).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($mogged,"modulate:a",1.0,0.8)
	tween.parallel().tween_property($mogged,"rotation_degrees",360,0.8).set_trans(Tween.TRANS_BACK)
	await tween.finished
	global.camshake = 10
	var timer = get_tree().create_timer(3)
	await timer.timeout
	get_tree().change_scene_to_file("res://scenes/characters/characterselect.tscn")
