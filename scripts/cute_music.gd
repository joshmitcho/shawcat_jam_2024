extends Node2D


const MEOWSERS = preload("res://sound/meowsers1.mp3")
const FIRST_IMPACT = preload("res://sound/first_impact.wav")


func _ready() -> void:
	SoundManager.play_sfx(FIRST_IMPACT, 1.01)
	SoundManager.play_soundscape(MEOWSERS, -16)

