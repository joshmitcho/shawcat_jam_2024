#play_screen.gd
extends Node2D
class_name PlayScreen

signal ladder_reached(ladder_position: Vector2)
signal cutscene_start()

@onready var pause_menu: Control = $"Camera2D/Main UI/PauseMenu"
@onready var levels_container: Node = $Levels
@onready var player: Player = $Player
@onready var squash_display: HBoxContainer = $"Camera2D/Main UI/SquashDisplay"

var current_level: int = 0
var levels: Array[PackedScene] = [
	preload("res://scenes/level_tutorial.tscn"),
	preload("res://scenes/level_falling.tscn"),
	preload("res://scenes/level_1.tscn"),
	preload("res://scenes/level_2.tscn"),
	preload("res://scenes/level_3.tscn")
]


func _ready() -> void:
	print(current_level)
	squash_display.hide()
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
	current_level += 1
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.BLACK, 2.0)
	await tween.finished
	
	var old_level = levels_container.get_child(0)
	old_level.queue_free()
	
	squash_display.show()
	player.global_position = Vector2.ZERO
	player.spin = 0
	player.rotation = 0
	player.sprite.flip_h = false
	player.in_control = true
	
	var new_level = levels[current_level].instantiate()
	levels_container.add_child(new_level)
	
	var tween2 := get_tree().create_tween()
	tween2.tween_property(self, "modulate", Color.WHITE, 2.0)


func pause() -> void:
	pause_menu.show()
	get_tree().paused = true


func unpause() -> void:
	pause_menu.hide()
	get_tree().paused = false
