extends Sprite2D

@export var move_in_time: float = 2.0
@export var move_out_time: float = 1.0
@export var move_in_x_start: float = 250.0
@export var move_in_x_half_range: float = 15.0
@export var move_out_y_target: float = -150.0
@export var move_out_y_half_range: float = 15.0

signal move_in_finished
signal move_out_finished

func move_in(target: Vector2):
	position.x = move_in_x_start + randf_range(move_in_x_half_range, -move_in_x_half_range)
	position.y = target.y
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position", target, move_in_time)
	tween.tween_callback(Callable(self, "move_in_finished"))
	
func move_out():
	var target = position
	target.y = move_out_y_target + randf_range(move_out_y_half_range, -move_out_y_half_range)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "position", target, move_out_time)
	tween.tween_callback(Callable(self, "move_out_finished"))



func _on_newspaper_in_button_down() -> void:
	move_in(Vector2(0.0, 0.0))

func _on_newspaper_out_button_down() -> void:
	move_out()
