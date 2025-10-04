extends CharacterBody2D

@export var move_speed: float = 100.0
@export var gravity: float = 1200.0
@export var patrol_distance: float = 200.0
@export var attack_cooldown: float = 2.0

var start_position: Vector2
var direction: int = 1
var distance_traveled: float = 0.0
var is_attacking: bool = false
var attack_timer: float = 0.0

enum AttackType { CHEESE, SHURIKEN, PUNCH, CRUST_WALL }

func _ready():
    start_position = global_position
    #$Sprite2D.texture = load("res://images/player.png")
    $Sprite2D.modulate = Color(1, 1, 0)  # Yellow placeholder for boss

func _physics_process(delta: float) -> void:
    # Gravity
    if not is_on_floor():
        velocity.y += gravity * delta

    if is_attacking:
        attack_timer -= delta
        if attack_timer <= 0:
            is_attacking = false
    else:
        # Patrol
        velocity.x = move_speed * direction
        distance_traveled += move_speed * delta * direction

        if abs(global_position.x - start_position.x) >= patrol_distance:
            direction *= -1

        # Decide to attack
        if randi() % 100 < 1:  # ~1% chance per frame to start attack
            start_attack()

    # Apply motion
    move_and_slide()

func start_attack():
    is_attacking = true
    attack_timer = attack_cooldown
    var attack_choice = int(randi() % 4)  # 0..3
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
