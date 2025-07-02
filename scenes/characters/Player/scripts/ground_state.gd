extends State

class_name GroundState

@export var jump_velocity = -600.0
@export_range(0,1) var decelerate_on_jump_release = 0.5

@export var air_state : State

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump(event)

# Handle character jump
func jump(event : InputEvent):
	character.velocity.y = jump_velocity
	next_state = air_state
