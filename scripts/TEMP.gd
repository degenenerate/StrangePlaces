extends Sprite2D

var count = 0

func _process(delta):
	count += delta
	position.x = sin(count) * 20
