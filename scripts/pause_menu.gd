#pause_menu.gd
extends CenterContainer



func _ready() -> void:
	pass


func unpause() -> void:
	hide()
	get_tree().paused = false


func quit() -> void:
	get_tree().quit()
