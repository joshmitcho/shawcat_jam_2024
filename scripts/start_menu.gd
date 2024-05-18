#start_menu.gd
extends TextureRect

const PLAY_SCREEN = preload("res://scenes/play_screen.tscn")

@onready var bg_music: AudioStreamPlayer = $BGMusic


func start_game() -> void:
	get_tree().change_scene_to_packed(PLAY_SCREEN)


func quit_game() -> void:
	get_tree().quit()
