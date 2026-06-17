extends CharacterBody2D

class_name basecontroller

@export var player : int = 1

@export var left : String
@export var right : String

@export var friction : float = 0.92
@export var speed : int = 60
@export var moveendlag : int = 20

@export var stuntime : int = 30

@export var supermovement : bool = false
var supermovementrailthing : int = 0
@export var heavyweight : bool = false


var hp : float = 100
var endlag : int = 0
var attacking : bool = false
var counterframes : int = 0
var iframes : int = 0

@export var target : Node2D
var targetpos : Vector2

var blurframes : int = 0

var stun : int = 0

var lastselectedmovement = 0

var justisonfloor : bool = false

func _ready() -> void:
	#set the collision layers for attackboxes and stuff
	match player:
		1: 
			set_collision_layer_value(2, true)
			for i in range($flip/attackboxes.get_child_count()):
				$flip/attackboxes.get_child(i).set_collision_mask_value(3,true)
			$pusher.set_collision_mask_value(3,true)
		2: 
			set_collision_layer_value(3, true)
			for i in range($flip/attackboxes.get_child_count()):
				$flip/attackboxes.get_child(i).set_collision_mask_value(2,true)
				$pusher.set_collision_mask_value(2,true)
	
	

func _process(delta: float) -> void:
	endlag -= 1
	blurframes -= 1
	counterframes -= 1
	iframes -= 1
	supermovementrailthing -= 1
	attacking = $animations.current_animation.contains("attack")
	
	if not justisonfloor == is_on_floor() and heavyweight:
		global.camshake = 5
	
	if stun > 1 and is_on_floor():
		if not justisonfloor == is_on_floor():
			iframes = stuntime * 0.2
			position.y += 20
		$CollisionShape2D.scale.y = 0.25
		$CollisionShape2D.position.y = 20
	else:
		$CollisionShape2D.scale.y = 1
		$CollisionShape2D.position.y = 0
	
	justisonfloor = is_on_floor()
	
	if supermovement and supermovementrailthing < 1:
		createtrail()
		supermovementrailthing = 3
	
	if is_on_floor(): stun -= 1
	
	if not target == null:
		targetpos = target.global_position
	else:
		targetpos = get_global_mouse_position()
	
	if not stun > 1:
		if not $animations.is_playing():
			$flip/sprite.play("idle")
			if not global.gameccomplete:
				controls()
		elif $animations.current_animation == "forward" or $animations.current_animation == "backward":
			attacks()
	else:
		if not is_on_floor():
			$flip/sprite.play("hurt")
		else:
			$flip/sprite.play("hurtground")
	
	if global.impactframes >= 1:
		$flip/sprite.modulate = Color("000000")
	else:
		$flip/sprite.modulate = Color("ffffff")
	
	
	if is_on_floor():
		velocity.x *= friction
	velocity.y += 2000 * delta
	
	move_and_slide()
	


func controls():
	
	if targetpos.x > position.x:
		$flip.scale.x = 1
	else:
		$flip.scale.x = -1
	
	if Input.is_action_just_pressed(left):
		handlemovement(-1)
	
	if Input.is_action_just_pressed(right):
		handlemovement(1)
	

func attacks():
	if Input.is_action_just_pressed(left):
		var input_forward = returnmovementthingy(-1)
		var moving_forward = $animations.current_animation == "forward"
		
		if moving_forward:
			if input_forward:
				$animations.play("attack1")
			else:
				$animations.play("attack2")
		else:
			if input_forward:
				$animations.play("attack3")
			else:
				$animations.play("attack4")
	
	if Input.is_action_just_pressed(right):
		var input_forward = returnmovementthingy(1)
		var moving_forward = $animations.current_animation == "forward"
		
		if moving_forward:
			if input_forward:
				$animations.play("attack1")
			else:
				$animations.play("attack2")
		else:
			if input_forward:
				$animations.play("attack3")
			else:
				$animations.play("attack4")
	
	


func returnmovementthingy(dir : int) -> bool: #true = forward, false = backward
	#if dir < 0:
		#if targetpos.x > position.x:
			#return false
		#else:
			#return true
	#else:
		#if targetpos.x < position.x:
			#return false
		#else:
			#return true
	if $flip.scale.x > 0:
		return dir > 0
	else:
		return dir < 0


func handlemovement(dir : int):
	blurframes = 8
	if supermovement: iframes = 10
	if dir < 0:
		if targetpos.x > position.x:
			$animations.play("backward")
			lastselectedmovement = -1
			
		else:
			$animations.play("forward")
			lastselectedmovement = 1
	else:
		if targetpos.x < position.x:
			$animations.play("backward")
			lastselectedmovement = -1
		else:
			$animations.play("forward")
			lastselectedmovement = 1

func moveforward(frames : int = 8):
	velocity.x = speed * $flip.scale.x * frames
	blurframes = 4
	bounce()


func movebackward(frames : int = 8):
	velocity.x = speed * -$flip.scale.x * frames
	blurframes = 4
	bounce()

func applymoveendlag():
	endlag = moveendlag



func damage(damage,kb,origin):
	if counterframes < 1 and iframes < 1:
		hp -= damage
		$animations.play("RESET")
		$look.look_at(origin)
		velocity = -kb * $look.transform.x
		velocity.y += -400
		position.y -= 5
		$flip/sprite.play("hurt")
		stun = stuntime
		if player == 1:
			global.p2combo += 1
		else:
			global.p1combo += 1
		justisonfloor = false
	elif counterframes >= 1:
		$animations.play("counter")


func hopup():
	velocity.y = -800

func hopdown():
	velocity.y = 300

func smallhop():
	velocity.y = -600

func smallerhop():
	velocity.y = -400

func superhop():
	velocity.y = -1200

func superslam():
	velocity.y = 2000

func zoomies():
	var tween = create_tween()
	tween.tween_property(self,"position",targetpos - Vector2(20 * $flip.scale.x,0),0.3).set_trans(Tween.TRANS_CUBIC)

func setvelx(value:float):
	velocity.x = value * $flip.scale.x

func instanttransmitioneffect():
	var tween = create_tween()
	tween.tween_property($flip/sprite,"scale",Vector2(3,2),0.2)
	tween.parallel().tween_property($flip/sprite,"modulate",Color(1,1,1,0),0.2).set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(0.05)
	tween.tween_property($flip/sprite,"scale",Vector2(2,2),0.2)
	tween.parallel().tween_property($flip/sprite,"offset",Vector2(0,0),0.2)
	tween.parallel().tween_property($flip/sprite,"modulate",Color(1,1,1,1),0.2)

func instanttransmition():
	velocity.x = $flip.scale.x * 400
	position.x = targetpos.x
	$flip.scale.x *= -1

func backwardsinstanttransmition():
	velocity.x = $flip.scale.x * 400
	position.x = targetpos.x
	

func timeskiptransmision():
	if target.attacking:
		counterthingy()
		velocity.x = $flip.scale.x * 400
		position.x = targetpos.x
		$flip.scale.x *= -1

func counter():
	counterframes = 20

func counterthingy():
	target.velocity = Vector2.ZERO
	target.damage(0,0,Vector2.ZERO)
	target.velocity *= 0
	target.stun = 84


func createkiblast():
	var b = preload("res://scenes/vfx/kiblast.tscn").instantiate()
	b.position = position + Vector2(20 * $flip.scale.x,0)
	b.position.y += randf_range(-5,5)
	b.scale.x *= $flip.scale.x
	get_tree().current_scene.add_child(b)

func createtrail():
	var tex = $flip/sprite.sprite_frames.get_frame_texture(
	$flip/sprite.animation,
	$flip/sprite.frame
	)
	var b = preload("res://scenes/vfx/ghosteffect.tscn").instantiate()
	get_tree().current_scene.add_child(b)
	b.position = $flip/sprite.global_position
	b.texture = tex
	b.scale = $flip/sprite.scale
	b.scale.x *= $flip.scale.x
	



func bounce():
	var tween = create_tween()
	tween.tween_property($flip/sprite, "scale",Vector2(2,1.8),0.1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($flip/sprite, "scale",Vector2(2,2),0.1).set_trans(Tween.TRANS_CUBIC)
