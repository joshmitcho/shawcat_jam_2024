#level.gd
extends Node2D
class_name Level

@onready var ladder: Area2D = $Ladder


func _ready() -> void:
	CatController.current_level = self


func _on_ladder_entered(body):
	if body.is_in_group("Player"):
		print("ladder")
		get_parent().get_parent().ladder_reached.emit(ladder.global_position)
	#get_tree().change_scene_to_file("res://scenes/level_1.tscn")
