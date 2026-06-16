extends Node2D

func _ready() -> void:
	Engine.time_scale = 1
	global.p1combo = 0
	global.p2combo = 0
	var b = load(global.player1).instantiate()
	b.player = 1
	b.left = "1left"
	b.right = "1right"
	
	
	var c = load(global.player2).instantiate()
	c.player = 2
	c.left = "2left"
	c.right = "2right"
	
	c.position = $"1spawn".global_position
	b.position = $"2spawn".global_position
	
	add_child(b)
	add_child(c)
	
	$Camera2D.node1 = b
	$Camera2D.node2 = c
	
	$Camera2D.position = (b.position + c.position)/2
	
	b.target = c
	c.target = b
	
	var t = get_tree().create_timer(0.8 * 4.0)
	await t.timeout
	$StaticBody2D2.queue_free()
	


func _process(delta: float) -> void:
	if global.p1combo >= 20 and not $hud/mogged.visible:
		$hud.mogged()
	if global.p2combo >= 20 and not $hud/mogged.visible:
		$hud.mogged()
