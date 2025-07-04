extends State

class_name LandingState

@export var ground_state : State
@export var landing_animation : String = "landing"

@onready var all_feathers: Node = $"../../../AllFeathers"

func state_process(delta):
	for feather in all_feathers.get_children():
		feather.already_used = false

	next_state = ground_state
	playback.stop()
	playback.travel(landing_animation)

