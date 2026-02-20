class_name BeatChecker extends Area2D

enum HitType {
	MISS,
	HIT,
	GREAT
}

@export var beatGroup := "Beat"

func hit_beat() -> HitType:
	var areas := get_overlapping_areas()
	
	if areas.is_empty():
		return HitType.MISS
	var minDistance: float = 10.0
	for area in areas:
		if not area.is_in_group(beatGroup):
			continue
		var beatArea := area as BeatArea
		beatArea.hit_beat() # <- Deletes beat via queue_free()
		var distance: float = abs(beatArea.global_position.y - global_position.y)
		minDistance = min(distance, minDistance)
	
	return HitType.GREAT if minDistance <= Globals.beat_great_distance else HitType.HIT
