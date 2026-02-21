extends Label

func _on_display_rhythm_score(perfect: int, great: int, streak: int, missed: int) -> void:
	text = "PERFECT: %3d\nGREAT: %3d\nSTREAK: %3d\nMISSED: %3d" % [perfect, great, streak, missed]
	print("changed")

func _ready() -> void:
	ScoreManager.display_rhythm_score.connect(_on_display_rhythm_score)
