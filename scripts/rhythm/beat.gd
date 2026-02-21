extends Node2D

@export var units_per_beat = 20
@onready var needle: Node2D = get_node("../../../Needle")

var note_length: float

var beat_container: Node2D

var units_until_hit: float
var beats_until_hit: float
var beat_id: int

func _ready() -> void:
	beat_container = get_parent()
	beat_id = beat_container.beats_list.size()
	beat_container.beats_list.push_back(self)

func _process(delta: float) -> void:
	position.y += Globals.bpm / 60 * units_per_beat * delta
	units_until_hit = needle.global_position.y - global_position.y
	beats_until_hit = units_until_hit / units_per_beat
	
	if (-1 * beats_until_hit > note_length):
		ScoreManager.add_missed_beat()
		beat_container.beats_list.erase(self)
		queue_free()
