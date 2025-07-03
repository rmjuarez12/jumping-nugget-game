extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var sfx_collected : AudioStreamPlayer2D

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		sprite.animation = "collected"
		sfx_collected.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	if (sprite.animation == "collected"):
		queue_free()


