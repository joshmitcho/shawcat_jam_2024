#cat_controller.gd
extends Node

signal update_squash_display(new_count: int)
signal swarm_start()
signal swarm_end()
signal smoke_start()

const CAT = preload("res://scenes/cat.tscn")

var squash_count: int = 0
var swarming: bool = false

var player: Player
var current_level: Level


func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("squash_cat"):
		cat_squashed()


func cat_squashed() -> void:
	if swarming:
		return
		
	squash_count += 1
	update_squash_display.emit(squash_count)
	if squash_count == 5:
		start_swarm()


func start_swarm():
	swarming = true
	
	var swarm_timer := get_tree().create_timer(3)
	swarm_start.emit()
	
	for i in range(50):
		var new_cat = CAT.instantiate()
		var new_cat_offset: Vector2 = Vector2(100 + randi_range(0, 200), 100 + randi_range(0, 200))
		new_cat.global_position = player.global_position + new_cat_offset.rotated(randf_range(0, 6))
		new_cat.flying = true
		current_level.add_child.call_deferred(new_cat)
		await get_tree().create_timer(0.01).timeout
	
	await swarm_timer.timeout
	
	swarm_end.emit()
	swarming = false
	squash_count = 0
	update_squash_display.emit(squash_count)
