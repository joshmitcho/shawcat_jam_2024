#cat.gd
class_name Cat
extends CharacterBody2D

var start_point: Vector2
var end_point: Vector2
var target_point: Vector2

var og_move_speed : float = 100.0
var move_speed : float = og_move_speed
var jump_force : float = 200.0
var gravity : float = 500.0


func _ready() -> void:
	start_point = $StartPoint.global_position
	end_point = $EndPoint.global_position
	target_point = start_point


func _physics_process(delta: float):
	global_position = global_position.move_toward(target_point, move_speed * delta)
	
	if CatController.swarming:
		target_point = CatController.player.global_position
		move_speed = og_move_speed * 3
	else:
		move_speed = og_move_speed
		
	
	if (global_position - target_point).length() <= 1:
		if target_point == start_point:
			target_point = end_point
		else:
			target_point = start_point


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if CatController.swarming:
			CatController.smoke_start.emit()
		else:
			CatController.cat_squashed()
		queue_free()
