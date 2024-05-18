extends Camera2D


var max_offset = Vector2(5, 5)  # Maximum hor/ver shake in pixels.
var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
@export var target: NodePath  # Assign the node this camera will follow.

@onready var noise = FastNoiseLite.new()

var decay = 0  # How quickly the shaking stops [0, 1].
var trauma: float = 0 # Current shake strength.
var trauma_power: float = 2  # Trauma exponent. Use [2, 3].


func _ready() -> void:
	randomize()
	CatController.swarm_start.connect(swarm_start)
	CatController.swarm_end.connect(swarm_end)


func swarm_start():
	trauma = 0.5
	decay = 0


func swarm_end():
	decay = 0.8


func _physics_process(delta: float) -> void:
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()


func shake() -> void:
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * randf_range(-1, 1)
	offset.x = max_offset.x * amount * randf_range(-1, 1)
	offset.y = max_offset.y * amount * randf_range(-1, 1)
