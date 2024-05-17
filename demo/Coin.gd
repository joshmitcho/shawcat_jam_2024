extends Area2D

var bob_height : float = 5.0
var bob_speed : float = 5.0

@onready var start_y : float = global_position.y
var t : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# increase 't' over time.
	t += delta
	
	# create a sin wave that bobs up and down.
	var d = (sin(t * bob_speed) + 1) / 2
	
	# apply that to the coin's Y position.
	global_position.y = start_y + (d * bob_height)

# when the player hits the coin, add score and destroy the coin.
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(1)
		queue_free()
