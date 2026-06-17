extends Control

var characterlist : PackedStringArray = ["res://scenes/characters/goku.tscn", "res://scenes/characters/vegeta.tscn", "res://scenes/characters/gohan.tscn", "res://scenes/characters/frieza.tscn", "res://scenes/characters/gokublack.tscn", "res://scenes/characters/hit.tscn","res://scenes/characters/broly.tscn"]

func _on_button_pressed() -> void:
	global.player2 = characterlist[$select1.currentselection]
	global.player1 = characterlist[$select2.currentselection]
	$transition.visible = true
	$transition.rotation_degrees = 0
	$transition.scale = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property($transition,"scale:x",1.0,0.8).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($transition,"scale:y",1.0,1.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($transition,"rotation_degrees",360,1.5).set_trans(Tween.TRANS_SINE)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/maps/testmap.tscn")

func _ready() -> void:
	var tween = create_tween()
	$transition.visible = true
	tween.tween_property($transition,"scale:x",0.0,0.8).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($transition,"scale:y",0.0,1.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property($transition,"rotation_degrees",360,1.5).set_trans(Tween.TRANS_SINE)
	
