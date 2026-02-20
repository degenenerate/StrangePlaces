class_name BeatArea extends Area2D

signal beat_hit

func hit_beat() -> void:
	beat_hit.emit()
