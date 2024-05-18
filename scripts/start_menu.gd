#start_menu.gd
extends TextureRect

const PLAY_SCREEN = preload("res://scenes/play_screen.tscn")


func _ready() -> void:
	SoundManager.play_soundscape(load("res://sound/creepo.mp3"), 0.0)


func start_game() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.BLACK, 2.0)
	await tween.finished
	get_tree().change_scene_to_packed(PLAY_SCREEN)


func quit_game() -> void:
	get_tree().quit()
