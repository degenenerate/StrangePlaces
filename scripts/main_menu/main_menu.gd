extends Node2D

func _on_start_button_down():
	Globals.scene_manager.next_scene()

func _on_quit_button_down():
	get_tree().quit()
