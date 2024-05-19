#level_tbc.gd
extends Node2D

var player: Player
@onready var bg: TextureRect = $BG

func _ready() -> void:
	player = CatController.player
	player.in_control = false
	player.velocity = Vector2.ZERO
	player.hide()
	SoundManager.play_soundscape(load("res://sound/creepo.mp3"), 0.0)
