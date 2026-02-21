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
var _this_beat_length: float
var _time_until_next: float

func _select_beat(idx: int) -> void:
	_next_beat = idx
	
	_beat_location = beat_info[idx][0]
	_this_beat_length = beat_info[idx][1]
	_time_until_next = beat_info[idx][1]

func _ready() -> void:
	ScoreManager.initialize()
	_select_beat(0)

func _process(delta: float) -> void:
	if not song_finished:
		_spawn_beats(delta)

func _spawn_beats(delta: float) -> void:
	_time_until_next -= delta
	if _time_until_next <= 0:
		if _beat_location >= 0:
			var _new_beat = beat_scene.instantiate()
			_new_beat.note_length = _this_beat_length
			beat_parents[_beat_location].add_child(_new_beat)
		
		if _next_beat + 1 < beat_info.size():
			_select_beat(_next_beat + 1)
			return
		
		song_finished = true

func _input(event: InputEvent) -> void:
	var beat_index := -1
	if event.is_action_pressed("beat_left"):
		beat_index = 0
	if event.is_action_pressed("beat_mid_left"):
		beat_index = 1
	if event.is_action_pressed("beat_mid_right"):
		beat_index = 2
	if event.is_action_pressed("beat_right"):
		beat_index = 3
		
	if beat_index == -1:
		return
		
	var last_note: Node2D = beat_parents[beat_index].beats_list.pop_front()
	if not last_note:
		ScoreManager.add_missed_beat()
		return     
		
	if abs(last_note.beats_until_hit) < Globals.great_beat_margin:
		ScoreManager.add_great_beat()
	else:
		ScoreManager.add_missed_beat()
	last_note.queue_free()
	
