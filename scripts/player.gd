extends CharacterBody2D

@export var move_speed: float = 200.0
@export var jump_force: float = -500.0
@export var gravity: float = 1200.0

var is_attacking: bool = false
var attack_duration: float = 0.2
var attack_timer: float = 0.0

func _ready():
	if $CollisionShape2D.shape == null:
		var rect = RectangleShape2D.new()
		rect.size = Vector2(50,100)
		$CollisionShape2D.shape = rect
	print("Player ready!")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var input_dir = Input.get_axis("ui_left","ui_right")
	velocity.x = input_dir * move_speed

	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

	if Input.is_action_just_pressed("attack") and not is_attacking:
		is_attacking = true
		attack_timer = attack_duration
		print("Attack!")

	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false

	move_and_slide()
