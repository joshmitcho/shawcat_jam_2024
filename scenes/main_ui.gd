extends Control

var time_since_last_death: int
@onready var timer: Label = $MarginContainer/Timer


func _ready() -> void:
	time_since_last_death = Time.get_ticks_msec()
	CatController.die.connect(die)


func die():
	time_since_last_death = Time.get_ticks_msec()


func _physics_process(delta: float) -> void:
	timer.text = time_to_minutes_secs_mili(Time.get_ticks_msec() - time_since_last_death)



func time_to_minutes_secs_mili(time : float):
	time = time/1000
	
	var mins = int(time) / 60
	time -= mins * 60
	var secs = int(time)
	return str("%0*d" % [2, mins]) + ":" + str("%0*d" % [2, secs])

