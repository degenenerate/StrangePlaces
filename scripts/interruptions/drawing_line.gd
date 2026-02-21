extends Line2D

var _area: Area2D
var _line: Line2D

var _mouse_inside: bool
var _mouse_clicked: bool

func _on_mouse_enter():
	_mouse_inside = true
func _on_mouse_exit():
	_mouse_inside = false

func _ready() -> void:
	_area = $"../Area2D"
	_line = $"../Line2D"
	
	_area.mouse_entered.connect(_on_mouse_enter)
	_area.mouse_exited.connect(_on_mouse_exit)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		_mouse_clicked = _mouse_inside
	if Input.is_action_just_released("click"):
		_mouse_clicked = false
	
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	if not _mouse_clicked:
		return
	if not _mouse_inside:
		return
	
	_line.add_point(get_local_mouse_position())
