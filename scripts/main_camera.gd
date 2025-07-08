extends Camera2D

@export var follow_target: Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	print(follow_target)
	if follow_target:
		position = follow_target.position
