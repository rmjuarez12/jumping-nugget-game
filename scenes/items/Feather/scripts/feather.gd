extends Area2D

@export var already_used: bool = false

@onready var particles: GPUParticles2D = $GPUParticles2D

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer" and not already_used):
		body.state_machine.air_state.can_second_jump = true
		body.state_machine.air_state.feather = self
		print(already_used)


func _on_body_exited(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		body.state_machine.air_state.can_second_jump = false
		body.state_machine.air_state.feather = null
