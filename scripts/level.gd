#level.gd
extends Node2D
class_name Level


func _ready() -> void:
	CatController.current_level = self

