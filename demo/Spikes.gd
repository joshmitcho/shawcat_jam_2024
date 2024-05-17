extends Area2D

# if the player hits the spikes, game over!
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
