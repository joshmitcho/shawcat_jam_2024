#cutscene.gd
extends Node2D

const CRUMBLING_GROUND = preload("res://sound/crumbling_ground.wav")

@onready var hero: AnimatedSprite2D = $Hero
@onready var extra_tiles: TileMap = $ExtraTiles


func start_cutscene(body) -> void:
	if body.is_in_group("Player"):
		get_parent().get_parent().cutscene_start.emit()
		
		await get_tree().create_timer(3).timeout
		
		extra_tiles.queue_free()
		hero.play("shock")
		SoundManager.play_sfx(CRUMBLING_GROUND, 1.05)
		body.spin = 3
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(body, "position", body.position + Vector2(0, 300), 1.0)
		get_parent().get_parent().next_level(Vector2.ZERO)

