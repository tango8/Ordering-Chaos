extends Node2D

func _ready():
	# Load Stage
	var stage_scene = load("res://scenes/stage.tscn") as PackedScene
	var stage_instance = stage_scene.instantiate()
	add_child(stage_instance)

	# Load Player
	var player_scene = load("res://scenes/player.tscn") as PackedScene
	var player_instance = player_scene.instantiate()
	add_child(player_instance)

	# Camera follows player
	var camera = Camera2D.new()
	player_instance.add_child(camera)
	camera.make_current()

	print("Main scene ready: Stage + Player loaded")
