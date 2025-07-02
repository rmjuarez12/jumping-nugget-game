extends State

class_name LandingState

@export var ground_state : State

func state_process(delta):
	next_state = ground_state
