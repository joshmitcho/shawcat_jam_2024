#cat_controller.gd
extends Node

signal update_squash_display(new_count: int)
signal swarm_start()
signal swarm_end()
signal smoke_start()

signal die()

const SWARM = preload("res://sound/you_made_them_angry.wav")
const WRATH = preload("res://sound/wrath.mp3")
const MEOWSERS = preload("res://sound/meowsers1.mp3")

var squash_count: int = 0
var swarming: bool = false

var player: Player

var player_died_to_swarm: bool = false


func cat_squashed() -> void:
	if swarming:
		return
	
	squash_count += 1
	update_squash_display.emit(squash_count)
	if squash_count >= 5:
		start_swarm()


func start_swarm():
	SoundManager.play_sfx(SWARM, -5)
	SoundManager.play_soundscape(WRATH, -6)
	swarming = true
	
	var swarm_timer := get_tree().create_timer(10)
	swarm_start.emit()
	
	await swarm_timer.timeout
	
	if not player_died_to_swarm:
		SoundManager.play_soundscape(MEOWSERS, -16)
		player_died_to_swarm = false
	swarm_end.emit()
	swarming = false
	squash_count = 0
	update_squash_display.emit(squash_count)
