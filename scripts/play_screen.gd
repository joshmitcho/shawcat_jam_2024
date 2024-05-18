#play_screen.gd
extends Node2D


@onready var pause_menu: Control = $"Camera2D/Main UI/PauseMenu"


func _ready() -> void:
	unpause()


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			unpause()
		else:
			pause()


func pause() -> void:
	pause_menu.show()
	get_tree().paused = true


func unpause() -> void:
	pause_menu.hide()
	get_tree().paused = false
