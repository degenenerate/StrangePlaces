extends Sprite2D

@export var unitsPerBeat = 20

func _process(delta: float) -> void:
	position.y += Globals.bpm / 60 * unitsPerBeat * delta
	print(Globals.bpm / 60 * unitsPerBeat * delta)
