class_name ParticleSystem extends Node2D

@export var _beat_perfect_particle: Resource
@export var _beat_great_particle: Resource
@export var _beat_miss_particle: Resource

static var _instance: ParticleSystem

func _ready() -> void:
	_instance = self


static func play_perfect_particle(pos: Vector2):
	_instance._play_particle(_instance._beat_perfect_particle, pos)
	
static func play_great_particle(pos: Vector2):
	_instance._play_particle(_instance._beat_great_particle, pos)
	
static func play_miss_particle(pos: Vector2):
	_instance._play_particle(_instance._beat_miss_particle, pos)

func _play_particle(particle: Resource, pos: Vector2):
	var new: Particle = particle.instantiate()
	add_child(new)
	new.global_position = pos
	new.play()
	print("New particle at ", pos)
