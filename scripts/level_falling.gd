#level_falling.gd
extends Node2D

const FALLIN = preload("res://sound/fallin.wav")

var player: Player
@onready var bg: TextureRect = $BG

func _ready() -> void:
	player = CatController.player
	player.in_control = false
	player.velocity = Vector2.ZERO
	player.spin = 3
	
	SoundManager.play_sfx(FALLIN, 0.9, -8)

	
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(bg, "position", Vector2(-630, -560), 4)
	await get_tree().create_timer(2).timeout
	get_parent().get_parent().next_level(Vector2.ZERO)

