extends Node2D

var shown: bool = false

func _ready():
	$Label.visible = false

func _on_area_2d_body_entered(_body):
	if not shown:
		$AnimationPlayer.play('show')
		$Label.visible = true
		shown = true
