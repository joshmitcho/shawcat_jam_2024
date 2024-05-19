#player.gd
extends CharacterBody2D
class_name Player

@onready var smoke: Sprite2D = $Smoke
@onready var sprite: AnimatedSprite2D = $Sprite

const STOMP = preload("res://sound/stomp.wav")
const WOOSH = preload("res://sound/woosh.wav")
const LAND = preload("res://sound/land.wav")
const START_MENU = preload("res://scenes/start_menu.tscn")
const CLIMB = preload("res://sound/climb.wav")

const GRAVITY := Vector2(0, 12)
const JUMP_POWER := 300
const OG_MAX_SPEED := 200
const FRICTION := 15
const MAX_JUMPS = 2
const INPUT_FORCE = 12

var max_speed : float = OG_MAX_SPEED
var current_jumps = 1

var was_on_floor: bool = true
var last_stomp_time: int = 0
var time_between_stomps := 500

var in_control: bool = true
var spin: float = 0

func _ready() -> void:
	CatController.player = self
	smoke.scale = Vector2.ZERO
	CatController.smoke_start.connect(smoke_start)
	CatController.swarm_end.connect(smoke_end)
	get_parent().ladder_reached.connect(climb_ladder)
	get_parent().cutscene_start.connect(cutscene)


func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		restart()
	
	if spin > 0:
		rotate(spin * delta)
	
	move_and_slide()
	
	if not in_control:
		return
	
	var input_dir: Vector2
	
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	if input_dir.x > 0:
		sprite.flip_h = false
	elif input_dir.x < 0:
		sprite.flip_h = true
	
	var net_force: Vector2 = input_dir.normalized() * INPUT_FORCE
	net_force += GRAVITY
	if velocity.y > 0:
		net_force += GRAVITY
	
	if (is_on_floor() and (
		(input_dir.x >= 0 and velocity.x < 0)
		or (input_dir.x <= 0 and velocity.x > 0))
	):
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
	velocity += net_force
	
	velocity = velocity.clamp(Vector2(-max_speed, -500), Vector2(max_speed, 500))

	if Input.is_action_just_pressed("ui_up"):
		if current_jumps < MAX_JUMPS:
			velocity.y = -JUMP_POWER
			SoundManager.play_shuffled_pitch_sfx(WOOSH)
			current_jumps = current_jumps + 1
		elif current_jumps > MAX_JUMPS:
			current_jumps = 1
	
	if is_on_floor():
		if not was_on_floor:
			was_on_floor = true
			SoundManager.play_shuffled_pitch_sfx(LAND, -10)
		current_jumps = 1
		if input_dir.x == 0:
			sprite.play("idle")
		else:
			sprite.play("walk")
			if Time.get_ticks_msec() - last_stomp_time > time_between_stomps:
				last_stomp_time = Time.get_ticks_msec()
				SoundManager.play_shuffled_pitch_sfx(STOMP, -8)
	else:
		was_on_floor = false
		sprite.play("air")
	
	smoke.rotate(delta * 3)
	
	# game over if we fall below the level.
	if global_position.y > 300:
		restart()


func cutscene() -> void:
	velocity = Vector2(0, 500)
	in_control = false


func climb_ladder(ladder_position: Vector2) -> void:
	SoundManager.play_sfx(CLIMB, 1.1, 6)
	in_control = false
	global_position.x = ladder_position.x
	velocity = Vector2(0, -100)
	sprite.play("climb")


func smoke_start() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(smoke, "scale", Vector2(2,2), 0.5)
	max_speed = OG_MAX_SPEED / 3.0
	await get_tree().create_timer(4).timeout
	game_over()


func smoke_end() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(smoke, "scale", Vector2.ZERO, 0.5)
	max_speed = OG_MAX_SPEED


func restart():
	CatController.player.global_position = Vector2.ZERO


# restarts the current scene.
func game_over ():
	if not CatController.player_died_to_swarm:
		CatController.squash_count = 0
		CatController.update_squash_display.emit(0)
		CatController.player_died_to_swarm = true
		CatController.swarm_end.emit()
		CatController.die.emit()
		get_tree().change_scene_to_packed(START_MENU)



