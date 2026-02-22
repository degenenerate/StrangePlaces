extends Node

@export var options: Array[Node]

func _ready() -> void:
	var the_chosen_one: Node = options.pick_random()
	
	for opt in options:
		if not opt == the_chosen_one:
			opt.queue_free()
