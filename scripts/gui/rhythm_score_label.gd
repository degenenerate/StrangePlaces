extends Label

func _on_display_rhythm_score(perfect: int, great: int, streak: int, missed: int) -> void:
	text = "PERFECT: %03d\nGREAT: %03d\nSTREAK: %03d\nMISSED: %03d" % [perfect, great, streak, missed]
	print("changed")

func _ready() -> void:
	ScoreManager.display_rhythm_score.connect(_on_display_rhythm_score)
