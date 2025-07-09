extends Area2D

@onready var game_manager: Node = get_node("/root/Stage/GameManager")

@onready var timer: Timer = $Timer

@export var sfx_death : AudioStreamPlayer

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		game_manager.player.state_machine.set_death_state()
		body.velocity = Vector2(0, 0)
		sfx_death.play()
		timer.start()


func _on_timer_timeout() -> void:
	game_manager.player_died()
	timer.stop()
