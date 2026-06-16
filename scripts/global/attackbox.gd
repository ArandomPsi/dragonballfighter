extends Area2D
class_name attackbox

@export var damage : float = 10
@export var kb : float = 1000


func _on_body_entered(body: Node2D) -> void:
	body.damage(damage,kb,global_position)
	
	if body.iframes < 1 and body.counterframes < 1:
		impact(body)
		hitstop()
		createblow(body)

func hitstop():
	var c = preload("res://scenes/vfx/hitstop.tscn").instantiate()
	get_tree().current_scene.add_child(c)
	global.camshake = 20

func impact(body):
	var b = preload("res://scenes/vfx/hiteffect.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	b.position = body.position
	b.get_child(1).look_at(self.global_position)

func createblow(body):
	var c = preload("res://scenes/vfx/blow.tscn").instantiate()
	get_tree().current_scene.add_child(c)
	c.position = body.position
	c.look_at(global_position)
