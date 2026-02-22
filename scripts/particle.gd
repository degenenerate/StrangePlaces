class_name Particle extends Node2D

@export var _particles: Array[GPUParticles2D]

func play() -> void:
	for i in _particles:
		i.emitting = true

func _on_timer_timeout() -> void:
	queue_free()
