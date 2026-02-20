class_name BeatChecker extends Area2D

@export var beatGroup := "Beat"

func hit_beat() -> bool:
	var areas := get_overlapping_areas()
	
	if areas.is_empty():
		return false
	for area in areas:
		if not area.is_in_group(beatGroup):
			continue
		var beatArea := area as BeatArea
		beatArea.hit_beat()
	return true
