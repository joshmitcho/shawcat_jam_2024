extends Area2D

@export_file("*.tscn") var next_scene

# when the player hits the flag, load the next level.
func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(next_scene)
