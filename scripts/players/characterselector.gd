extends Node2D
@export var player : int = 1

var currentselection : int = 0

@export var totalchildren : int = 6


func _process(delta: float) -> void:
	position.y = lerpf(position.y,(currentselection-1) * -300, 0.1)
	
	if Input.is_action_just_pressed(str(player) + "left"):
		currentselection -= 1
	
	if Input.is_action_just_pressed(str(player) + "right"):
		currentselection += 1
	
	currentselection = clamp(currentselection,0,totalchildren)
	
	for i in range(totalchildren + 1):
		if not i == currentselection:
			get_child(i).scale = lerp(get_child(i).scale,Vector2(1,1),0.1)
			get_child(i).position.x = lerpf(get_child(i).position.x,0.0,0.1)
		else:
			get_child(i).scale = lerp(get_child(i).scale,Vector2(2,2),0.1)
			get_child(i).position.x = lerpf(get_child(i).position.x,20.0,0.1)
	
	
	
