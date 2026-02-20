extends Node

var beat_info: Array[Array] = [
	[0, 1.0],
	[1, 1.0],
	[2, 1.0],
	[3, 1.0],
	[0, 1.0],
	[0, 1.0],
	[3, 1.0],
	[3, 1.0],
	[0, 1.0],
	[3, 1.0],
	[1, 1.0],
	[2, 1.0],
	[3, 1.0],
	[3, 1.0],
	[2, 1.0],
	[1, 1.0]
]

@export var beat_scene: Resource
@export var beat_parents: Array[Node2D]

var song_finished: bool = false

var _next_beat: int
var _beat_location: int
var _time_until_next: float

func _select_beat(idx: int) -> void:
	_next_beat = idx
	
	_beat_location = beat_info[idx][0]
	_time_until_next = beat_info[idx][1]

func _ready() -> void:
	_select_beat(0)

func _process(delta: float) -> void:
	if not song_finished:
		_spawn_beats(delta)

func _spawn_beats(delta: float) -> void:
	_time_until_next -= delta
	if _time_until_next <= 0:
		if _beat_location >= 0:
			var _new_beat = beat_scene.instantiate()
			beat_parents[_beat_location].add_child(_new_beat)
		
		if _next_beat + 1 < beat_info.size():
			_select_beat(_next_beat + 1)
			return
		
		song_finished = true
