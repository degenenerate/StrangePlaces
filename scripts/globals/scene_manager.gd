class_name SceneManager
extends Node

enum {
	DELETE,
	PAUSE,
	HIDE,
	DONOTHING
}

const gui_scenes: Array[PackedScene] = [
	preload("res://scenes/gui/game_menu_gui.tscn"),
	preload("res://scenes/gui/level_1_gui.tscn"),
	preload("res://scenes/gui/level_1_gui.tscn")
]

const world_scenes: Array[PackedScene] = [
	preload("res://scenes/world/game_menu.tscn"),
	preload("res://scenes/world/level_1.tscn"),
	preload("res://scenes/world/level_platformer.tscn")
]

@onready var _scene_transition = $SceneTransition
@onready var world: Node2D = $World
@onready var gui: Control = $CanvasLayer/Control

var _current_gui_scene = null
var _current_world_scene = null

var _queued_gui_status = DELETE
var _queued_gui_idx = 0
var _queued_world_status = DELETE
var _queued_world_idx = 0

func _ready():
	Globals.scene_manager = self
	_scene_transition.wipe_out_finished.connect(_on_wipe_finished)
	
	_on_wipe_finished()

func prev_scene():
	if _queued_world_idx - 1 >= 0:
		queue_scene(_queued_world_idx - 1)
	else:
		queue_scene(world_scenes.size()-1)

func restart_scene():
	queue_scene(_queued_world_idx)

func next_scene():
	if _queued_world_idx + 1 < world_scenes.size():
		queue_scene(_queued_world_idx + 1)
	else:
		queue_scene(0)

func queue_scene(_index: int, _status=DELETE):
	queue_gui_scene(_index, _status)
	queue_world_scene(_index, _status)
	
	_scene_transition.wipe_out()

func queue_gui_scene(_index: int, _status=DELETE):
	_queued_gui_status = _status
	_queued_gui_idx = _index

func queue_world_scene(_index: int, _status=DELETE):
	_queued_world_status = _status
	_queued_world_idx = _index
	
func _on_wipe_finished():
	_change_gui_scene()
	_change_world_scene()
	
	print(_current_world_scene)
	_scene_transition.wipe_in()

func _change_gui_scene():
	_unload_gui_scene()
	_current_gui_scene = gui_scenes[_queued_gui_idx].instantiate()
	gui.add_child(_current_gui_scene)

func _change_world_scene():
	_unload_world_scene()
	_current_world_scene = world_scenes[_queued_world_idx].instantiate()
	world.add_child(_current_world_scene)

func _unload_gui_scene():
	if _current_gui_scene == null:
		return
	match _queued_gui_status:
		DELETE:
			_current_gui_scene.queue_free()
		PAUSE:
			_current_gui_scene.get_parent().remove_child(_current_gui_scene)
		HIDE:
			_current_gui_scene.visible = false

func _unload_world_scene():
	if _current_world_scene == null:
		return
	match _queued_world_status:
		DELETE:
			_current_world_scene.queue_free()
		PAUSE:
			_current_world_scene.get_parent().remove_child(_current_world_scene)
		HIDE:
			_current_world_scene.visible = false
