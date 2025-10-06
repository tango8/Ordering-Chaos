extends CharacterBody2D

@export var move_speed: float = 100.0
@export var gravity: float = 1200.0
@export var patrol_distance: float = 200.0
@export var attack_cooldown: float = 2.0
@export var edge_pause_time: float = 0.5  # Pause at edges before turning

var start_position: Vector2
var direction: int = 1
var is_attacking: bool = false
var attack_timer: float = 0.0
var pause_timer: float = 0.0

func _ready():
	start_position = global_position

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0  # reset vertical velocity when on floor

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
	else:
		if pause_timer > 0:
			# Pause at edge
			pause_timer -= delta
			velocity.x = 0
		else:
			# Patrol movement
			velocity.x = move_speed * direction

			var dist_from_start = global_position.x - start_position.x

			if abs(dist_from_start) >= patrol_distance:
				velocity.x = 0 # stop first to prevent backwards slip
				pause_timer = edge_pause_time
				direction *= -1
			
				# Optional: flip sprite or trigger turn animation here
				# e.g., $Sprite.flip_h = direction < 0

		# Decide to attack randomly (if not paused)
		if pause_timer <= 0 and randi() % 100 < 1:  # ~1% chance per frame
			start_attack()

	move_and_slide()

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
