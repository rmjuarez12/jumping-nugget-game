extends Area2D

@export var teleport_destination: Marker2D
@onready var checkpoint: Marker2D = get_node("/root/Stage/Checkpoint")

@export var transition_fade: PackedScene

@onready var main_camera: Camera2D = get_node("/root/Stage/MainCamera")
@export var camera_limit_left: int
@export var camera_limit_right: int
@export var camera_limit_top: int
@export var camera_limit_bottom: int

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		var new_char_pos = Vector2(teleport_destination.position.x + position.x, teleport_destination.position.y + position.y)

		var transition_instance = transition_fade.instantiate()
		add_child(transition_instance)
		transition_instance.animation_player.play("fadein")

		await transition_instance.animation_player.animation_finished

		transition_instance.animation_player.play("fadeout")
		
		main_camera.limit_left = camera_limit_left
		main_camera.limit_right = camera_limit_right
		main_camera.limit_top = camera_limit_top
		main_camera.limit_bottom = camera_limit_bottom

		body.position = new_char_pos
		checkpoint.position = new_char_pos

		await transition_instance.animation_player.animation_finished

		transition_instance.queue_free()
