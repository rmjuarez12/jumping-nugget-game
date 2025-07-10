extends Area2D

@export var already_used: bool = false
@export var feather_type: String = "gold"

@onready var particles: GPUParticles2D = $GPUParticles2D

func _process(_delta: float) -> void:
	if not already_used:
		particles.emitting = true
	else:
		particles.emitting = false

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer" and not already_used):
		body.state_machine.air_state.can_second_jump = true
		body.state_machine.air_state.feather = self
		body.state_machine.air_state.second_jump_type = feather_type


func _on_body_exited(body:Node2D) -> void:
	if (body.name == "MainPlayer"):
		body.state_machine.air_state.can_second_jump = false
		body.state_machine.air_state.feather = null
