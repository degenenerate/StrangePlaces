extends Node2D

@export var sign_scene: Resource
@export var spawn_interval: float = 6.0
@export var spawn_interval_half_range: float = 1.0
@export var spawn_timer: Timer
@export var spawn_top_left: Node2D
@export var spawn_bot_right: Node2D

func _on_timer_timeout() -> void:
	var time = spawn_interval + randf_range(spawn_interval_half_range, -spawn_interval_half_range)
	spawn_timer.start(time)
	
	var spawnPosition = Vector2(randf_range(spawn_top_left.position.x, spawn_bot_right.position.x), randf_range(spawn_top_left.position.y, spawn_bot_right.position.y))
	var sign = sign_scene.instantiate() as Sign
	add_child(sign)
	sign.move_in(spawnPosition)
