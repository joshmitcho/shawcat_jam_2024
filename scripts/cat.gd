#cat.gd
class_name Cat
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite

var start_point: Vector2
var end_point: Vector2
var target_point: Vector2

var og_move_speed : float = 100.0
var move_speed : float = og_move_speed
var jump_force : float = 200.0
var gravity : float = 500.0

var flying: bool = false
var swarming: bool = false


func _ready() -> void:
	start_point = $StartPoint.global_position
	end_point = $EndPoint.global_position
	target_point = start_point
	CatController.swarm_start.connect(start_swarm)
	CatController.swarm_end.connect(end_swarm)


func _physics_process(delta: float):
	
	if swarming:
		if flying:
			target_point = CatController.player.global_position
			move_speed = og_move_speed * 3
			global_position = global_position.move_toward(target_point, move_speed * delta)
		else:
			if global_position < CatController.player.global_position:
				velocity.x = og_move_speed

				print("move right: ", velocity)
			else:
				velocity.x = -og_move_speed
				print("move left")
			velocity.y += 12
			move_and_slide()
	else:
		move_speed = og_move_speed
		global_position = global_position.move_toward(target_point, move_speed * delta)
	
		if (global_position - target_point).length() <= 1:
			if target_point == start_point:
				target_point = end_point
			else:
				target_point = start_point
	
	if target_point.x > global_position.x or velocity.x > 0:
		sprite.flip_h = false
	elif target_point.x < global_position.x or velocity.x < 0:
		sprite.flip_h = true


func start_swarm() -> void:
	if (global_position - CatController.player.global_position).length() < 400:
		swarming = true
		sprite.play("transform")
		await sprite.animation_finished
		sprite.play("walk_transformed")


func end_swarm() -> void:
	if not swarming:
		return
	
	swarming = false
	sprite.play_backwards("transform")
	await sprite.animation_finished
	sprite.play("walk")


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if CatController.swarming:
			CatController.smoke_start.emit()
		else:
			CatController.cat_squashed()
		queue_free()
