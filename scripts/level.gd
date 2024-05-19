#level.gd
extends Node2D
class_name Level

@onready var ladder: Area2D = $Ladder


func _on_ladder_entered(body):
	if body.is_in_group("Player"):
		get_parent().get_parent().ladder_reached.emit(ladder.global_position)

