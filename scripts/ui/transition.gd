extends ColorRect

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self,"scale:x",0.0,0.8).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self,"scale:y",0.0,1.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self,"rotation_degrees",360,1.5).set_trans(Tween.TRANS_SINE)

func transitionout():
	var tween = create_tween()
	tween.tween_property(self,"scale:x",1.0,0.8).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self,"scale:y",1.0,1.5).set_trans(Tween.TRANS_CUBIC)
	tween.parallel().tween_property(self,"rotation_degrees",360,1.5).set_trans(Tween.TRANS_SINE)
