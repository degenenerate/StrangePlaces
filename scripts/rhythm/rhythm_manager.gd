extends Node2D

func _ready() -> void:
	BackgroundMusic.playing = false
	BackgroundMusic.get_child(0).playing = true
