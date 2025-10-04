extends Node2D

func _ready():
	var player = $Player
	var stage = $Stage

	# Example: move player to starting position
	player.position = Vector2(-200, 150)

	print("Main scene ready")
