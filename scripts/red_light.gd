#red_light.gd
extends PointLight2D



func _ready() -> void:
	CatController.swarm_start.connect(swarm_start)
	CatController.swarm_end.connect(swarm_end)
	energy = 0


func swarm_start():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "energy", 10, 0.5)


func swarm_end():
	var tween := get_tree().create_tween()
	tween.tween_property(self, "energy", 0, 0.5)
