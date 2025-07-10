extends Camera2D

var move_camera: bool = false
@export var speed = 300.0

func _ready() -> void:
	await get_tree().create_timer(1).timeout

	print("Camera2D ready")
	move_camera = true

func _process(delta: float) -> void:
	if move_camera:
		position = position.move_toward(Vector2(position.x, 400), speed * delta)
