extends CharacterBody2D

@export var maxSpeed: float = 200.0
@export var acceleration: float = 2000.0
@export var slowdownMultiplier: float = 5.0
@export var jumpVelocity: float = 400.0

func _physics_process(delta: float) -> void:
	var moveDirection = Vector2(0.0, 0.0)
	if Input.is_action_pressed("move_right"):
		moveDirection += Vector2(+1.0, 0.0)
	if Input.is_action_pressed("move_left"):
		moveDirection += Vector2(-1.0, 0.0)
		
	var horizontal = velocity.x
	horizontal += moveDirection.x * acceleration * delta
	horizontal = clamp(horizontal, -maxSpeed, maxSpeed)
	if moveDirection.x == 0.0:
		horizontal = lerp(horizontal, 0.0, delta * slowdownMultiplier)
	
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	var vertical = velocity.y
	vertical += gravity * delta
	if is_on_floor():
		vertical = 0
		if Input.is_action_just_pressed("move_jump"):
			vertical = -jumpVelocity
			
	velocity = Vector2(horizontal, vertical)
	
	move_and_slide()
