extends Area2D

@export var object_to_focus: Node2D
@onready var main_camera: Camera2D = $"../../MainCamera"

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		main_camera.follow_target = object_to_focus
