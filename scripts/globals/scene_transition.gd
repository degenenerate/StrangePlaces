extends CanvasLayer

signal wipe_out_finished

var animationPlayer: AnimationPlayer

func _ready():
	animationPlayer = $AnimationPlayer
	animationPlayer.animation_finished.connect(on_anim_finished)

func wipe_in():
	animationPlayer.play("wipe_in")

func wipe_out():
	animationPlayer.play("wipe_out")

func on_anim_finished(anim_name: String):
	if anim_name == "wipe_out":
		wipe_out_finished.emit()
