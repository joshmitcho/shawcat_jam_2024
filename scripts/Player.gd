extends CharacterBody2D
class_name Player

@onready var smoke: Sprite2D = $Smoke

const OG_MOVE_SPEED: float = 100.0
var move_speed : float = OG_MOVE_SPEED
var jump_force : float = 200.0
var gravity : float = 500.0


func _ready() -> void:
	CatController.player = self
	smoke.scale = Vector2.ZERO
	CatController.smoke_start.connect(smoke_start)
	CatController.swarm_end.connect(smoke_end)


func _physics_process(delta: float):
	# gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	
	# move left.
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
	# move right.
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
		
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = -jump_force
		
	move_and_slide()
	
	smoke.rotate(delta * 3)
	
	# game over if we fall below the level.
	if global_position.y > 200:
		game_over()


func smoke_start() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(smoke, "scale", Vector2(0.5, 0.5), 0.5)
	move_speed = OG_MOVE_SPEED / 3.0


func smoke_end() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(smoke, "scale", Vector2.ZERO, 0.5)
	move_speed = OG_MOVE_SPEED


# restarts the current scene.
func game_over ():
	get_tree().reload_current_scene.call_deferred()
