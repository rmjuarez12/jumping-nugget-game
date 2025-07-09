extends State

class_name DeathState

@export var death_animation: String = "death"
@export var sfx_death : AudioStreamPlayer2D

func on_enter() -> void:
	playback.stop()
	playback.travel(death_animation)
	sfx_death.play()
