extends State

class_name LandingState

@export var ground_state : State
@export var landing_animation : String = "landing"

func state_process(delta):
	next_state = ground_state
	playback.stop()
	playback.travel(landing_animation)
