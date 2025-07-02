extends State

class_name AirState

@export_range(0,1) var decelerate_on_jump_release = 0.5

@export var landing_state : State

func state_input(event : InputEvent):
	if(event.is_action_released("jump")):
		cancel_jump()

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state

# Handle jump cancel, in case player lets go early of button
func cancel_jump():
	character.velocity.y *= decelerate_on_jump_release
