extends Node

var perfect_beats: int
var great_beats: int
var beat_streak: int
var missed_beats: int

var resolved_messages: int
var unresolved_messages: int

signal display_rhythm_score(perfect: int, great: int, streak: int, missed: int)

func initialize() -> void:
	perfect_beats = 0
	great_beats = 0
	beat_streak = 0
	missed_beats = 0
	
	resolved_messages = 0
	unresolved_messages = 0

func add_perfect_beat():
	perfect_beats += 1
	beat_streak += 1
		
	display_rhythm_score.emit(perfect_beats, great_beats, beat_streak, missed_beats)

func add_great_beat():
	great_beats += 1
	beat_streak += 1
	
	display_rhythm_score.emit(perfect_beats, great_beats, beat_streak, missed_beats)
	
func add_missed_beat():
	missed_beats += 1
	beat_streak = 0

	display_rhythm_score.emit(perfect_beats, great_beats, beat_streak, missed_beats)
