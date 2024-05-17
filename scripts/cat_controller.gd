#cat_controller.gd
extends Node

signal update_squash_display(new_count: int)
signal swarm_start()
signal swarm_end()

var squash_count: int = 0
var swarming: bool = false


func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
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
	
	await swarm_timer.timeout
	
	swarm_end.emit()
	swarming = false
	squash_count = 0
	update_squash_display.emit(squash_count)