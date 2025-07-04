extends Area2D

@export var game_manager: Node

@onready var timer: Timer = $Timer

@export var sfx_death : AudioStreamPlayer2D

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		game_manager.player.state_machine.set_death_state()
		sfx_death.play()
		timer.start()

func _on_timer_timeout() -> void:
	game_manager.player_died()
	timer.stop()
