extends Node2D

func _ready():
	$Label.visible = false

func _on_area_2d_body_entered(body):
	$AnimationPlayer.play('show')
	$Label.visible = true
