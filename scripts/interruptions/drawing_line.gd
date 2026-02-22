extends Line2D

@export var _required_areas: Array[Area2D]
var _written_areas: Array[bool]

var _area: Area2D
var _line: Line2D

var _mouse_inside: bool
var _mouse_clicked: bool

func _on_mouse_enter():
	_mouse_inside = true
func _on_mouse_exit():
	_mouse_inside = false

func _on_mouse_enter_required(req_area: Area2D):
	if not _mouse_clicked: return
	
	_written_areas[_required_areas.find(req_area)] = true
	if (_written_areas.count(true) == _written_areas.size()):
		$"../..".sign_done.emit()

func _ready() -> void:
	_area = $"../Paper"
	_line = $"../Line2D"
	
	_area.mouse_entered.connect(_on_mouse_enter)
	_area.mouse_exited.connect(_on_mouse_exit)
	
	for req_area in _required_areas:
		req_area.mouse_entered.connect(_on_mouse_enter_required.bind(req_area))
	
	_written_areas.resize(_required_areas.size())
	_written_areas.fill(false)

func _process(_delta: float) -> void:
	var sfx: AudioStreamPlayer2D = BackgroundMusic.get_child(2)
	if Input.is_action_just_pressed("click"):
		_mouse_clicked = _mouse_inside
		sfx.playing = true
		sfx.stream_paused = false
	if Input.is_action_just_released("click"):
		_mouse_clicked = false
		sfx.stream_paused = true
	
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
	if not _mouse_clicked:
		return
	if not _mouse_inside:
		return
	
	_line.add_point(get_local_mouse_position())
