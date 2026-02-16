extends CanvasLayer

const levels: Array[String] = [
	"res://scenes/tools/game_menu.tscn",
	"res://scenes/main.tscn",
	"res://scenes/tools/end_roll.tscn"
]

var _current_scene_idx = 0
var _current_scene = null
var _wipe_animation: AnimationPlayer

func _ready():
	var root = get_tree().root
	_current_scene = root.get_child(root.get_child_count() - 1)
	_wipe_animation = get_node("AnimationPlayer")
	_wipe_animation.play("wipe_in")

func prev_scene():
	if _current_scene_idx - 1 >= 0:
		goto_scene(_current_scene_idx - 1, Color.ROYAL_BLUE)
	else:
		goto_scene(levels.size()-1, Color.ROYAL_BLUE)

func restart_scene():
	goto_scene(_current_scene_idx, Color.DARK_RED)

func next_scene():
	if _current_scene_idx + 1 < levels.size():
		goto_scene(_current_scene_idx + 1, Color.ROYAL_BLUE)
	else:
		goto_scene(0, Color.ROYAL_BLUE)

func goto_scene(index: int, _wipe_color: Color):
	call_deferred("wipe_out", index, _wipe_color)

func wipe_out(index: int, _wipe_color: Color):
	_wipe_animation.play("wipe_out")
	await _wipe_animation.animation_finished
	
	_current_scene_idx = index
	call_deferred("_deferred_goto_scene", levels[index], _wipe_color)

func _deferred_goto_scene(path: String, _wipe_color: Color):
	_current_scene.free()

	var newScene = ResourceLoader.load(path)
	_current_scene = newScene.instantiate()

	get_tree().root.add_child(_current_scene)
	get_tree().current_scene = _current_scene

	call_deferred("wipe_in", _wipe_color)

func wipe_in(_wipe_color: Color):
	_wipe_animation.play("wipe_in")
