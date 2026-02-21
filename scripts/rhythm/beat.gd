extends Sprite2D

@export var units_per_beat = 20

var beat_container: Node2D
var beat_id: int

func _ready() -> void:
	beat_id = 

func _process(delta: float) -> void:
	position.y += Globals.bpm / 60 * units_per_beat * delta
	#print(Globals.bpm / 60 * unitsPerBeat * delta)


func _on_area_2d_beat_hit() -> void:
	queue_free()
