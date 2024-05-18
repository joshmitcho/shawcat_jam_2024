#play_screen.gd
extends Node2D
class_name PlayScreen

signal ladder_reached(ladder_position: Vector2)

@onready var pause_menu: Control = $"Camera2D/Main UI/PauseMenu"


func _ready() -> void:
	unpause()
	modulate = Color.BLACK
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 2.0)
	ladder_reached.connect(next_level)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if get_tree().paused:
			unpause()
		else:
			pause()


func next_level(_lp) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.BLACK, 2.0)


func pause() -> void:
	pause_menu.show()
	get_tree().paused = true


func unpause() -> void:
	pause_menu.hide()
	get_tree().paused = false
