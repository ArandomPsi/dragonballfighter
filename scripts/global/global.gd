extends Node

var camshake : int = 0
var impactframes : int = 0

var player1 : String = "res://scenes/characters/goku.tscn"
var player2 : String = "res://scenes/characters/goku.tscn"

var p1combo : int = 0
var p2combo : int = 0

var gameccomplete : bool = false

func _process(delta: float) -> void:
	impactframes -= 1
	if p1combo >= 20 or p2combo >= 20:
		gameccomplete = true
	else:
		gameccomplete = false
