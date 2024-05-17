#squash_count.gd
extends Label

var cat_count: int = 0


func _ready() -> void:
	show_squash_count(0)
	CatController.update_squash_display.connect(show_squash_count)
	CatController.swarm_start.connect(swarm_start)
	CatController.swarm_end.connect(swarm_end)


func show_squash_count(new_count: int) -> void:
	text = str(new_count) + "/5"


func swarm_start():
	modulate = Color.RED


func swarm_end():
	modulate = Color.WHITE
