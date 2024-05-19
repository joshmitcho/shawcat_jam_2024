#squash_display.gd
extends HBoxContainer

@onready var squash_count: Label = $SquashCount
@onready var cat_icon: TextureRect = $CatIcon

var cat_count: int = 0
var default_icon_rect: Rect2 = Rect2(0, 0, 16, 16)
var swarming_icon_rect: Rect2 = Rect2(0, 81, 16, 16)


func _ready() -> void:
	CatController.update_squash_display.connect(update_squash_display)
	CatController.swarm_start.connect(swarm_start)
	CatController.swarm_end.connect(swarm_end)


func update_squash_display(new_count: int) -> void:
	squash_count.text = str(new_count) + "/5"


func swarm_start():
	cat_icon.texture.region = swarming_icon_rect
	modulate = Color(1, 0.4, 0.4)


func swarm_end():
	cat_icon.texture.region = default_icon_rect
	modulate = Color.WHITE
