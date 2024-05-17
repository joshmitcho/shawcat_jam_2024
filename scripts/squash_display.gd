#squash_display.gd
extends HBoxContainer

@onready var squash_count: Label = $SquashCount

var cat_count: int = 0


func _ready() -> void:
	update_squash_display(0)
	CatController.update_squash_display.connect(update_squash_display)
	CatController.swarm_start.connect(swarm_start)
	CatController.swarm_end.connect(swarm_end)


func update_squash_display(new_count: int) -> void:
	squash_count.text = str(new_count) + "/5"


func swarm_start():
	modulate = Color.RED


func swarm_end():
	modulate = Color.WHITE
