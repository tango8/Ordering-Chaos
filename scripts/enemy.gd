extends CharacterBody2D

@export var move_speed: float = 100.0
@export var gravity: float = 1200.0
@export var patrol_distance: float = 100.0
@export var attack_cooldown: float = 2.0
@export var jump_force: float = 300.0

var start_position: Vector2
var direction: int = 1
var is_attacking: bool = false
var attack_timer: float = 0.0

func _ready():
	start_position = global_position

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_attack_timer(delta)
	rand_jump()

	if is_attacking:
		velocity.x = 0
		move_and_slide()
		return

	handle_patrol()
	rand_attack()

	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

func handle_attack_timer(delta: float) -> void:
	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false

func handle_patrol() -> void:
	# Flip direction if hitting wall
	if is_on_wall():
		direction *= -1

	# Calculate patrol distance and flip direction if needed
	var dist_from_start = global_position.x - start_position.x
	if abs(dist_from_start) >= patrol_distance:
		direction *= -1

	velocity.x = move_speed * direction

func rand_attack() -> void:
	# 1% chance per frame
	if randf() < 0.01:
		start_attack()

func rand_jump() -> void:
	if is_on_floor() and randf() < 0.01:  # 1% chance per frame
		velocity.y = -jump_force

func start_attack():
	is_attacking = true
	attack_timer = attack_cooldown
	var attack_choice = int(randi() % 4)
	match attack_choice:
		0:
			cheese_attack()
		1:
			shuriken_attack()
		2:
			punch_attack()
		3:
			crust_wall_attack()

func cheese_attack():
	print("Cheese attack!")

func shuriken_attack():
	print("Shuriken attack!")

func punch_attack():
	print("Punch attack!")

func crust_wall_attack():
	print("Crust wall attack!")
