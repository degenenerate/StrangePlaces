extends TextureRect

var _buffer_material: ShaderMaterial

var _prev_mouse_pos := Vector2(-1000, 0);
var _mouse_pos := Vector2(-1000,0);

func _ready() -> void:
	_buffer_material = $"../BufferViewport/ColorRect".material
	
func _process(delta: float) -> void:
	var sfx: AudioStreamPlayer2D = BackgroundMusic.get_child(2)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_mouse_pos = get_viewport().get_mouse_position()
		_buffer_material.set_shader_parameter("_mousePos", _mouse_pos)
		_buffer_material.set_shader_parameter("_prevMousePos", _prev_mouse_pos)
		_prev_mouse_pos = _mouse_pos
		sfx.playing = true
		sfx.stream_paused = false
	else:
		_prev_mouse_pos = Vector2(-1000, 0)
		#sfx.playing = false
		sfx.stream_paused = true
