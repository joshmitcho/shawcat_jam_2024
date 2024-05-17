#cat.gd
class_name Cat
extends CharacterBody2D

var start_point: Vector2
var end_point: Vector2
var target_point: Vector2

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0


func _ready() -> void:
	start_point = $StartPoint.global_position
	end_point = $EndPoint.global_position
	target_point = start_point


func _physics_process(delta: float):
	global_position = global_position.move_toward(target_point, move_speed * delta)
	
	if (global_position - target_point).length() <= 1:
		if target_point == start_point:
			target_point = end_point
		else:
			target_point = start_point


func _on_body_entered(body):
	if body.is_in_group("Player"):
		CatController.cat_squashed()
		queue_free()
