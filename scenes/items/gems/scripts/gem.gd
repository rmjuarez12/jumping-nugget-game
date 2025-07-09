extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager: Node = $"../../GameManager"

@onready var checkpoint: Marker2D = get_node("/root/Stage/Checkpoint")

@export var sfx_collected : AudioStreamPlayer2D

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		sprite.animation = "collected"
		sfx_collected.play()
		game_manager.add_gem(self)
		checkpoint.position = position

func _on_animated_sprite_2d_animation_finished() -> void:
	if (sprite.animation == "collected"):
		queue_free()
