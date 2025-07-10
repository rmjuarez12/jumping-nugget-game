extends State

class_name GroundState

@export var jump_velocity = -600.0
@export_range(0,1) var decelerate_on_jump_release = 0.5

@export var jump_animation : String = "jump"
@export var falling_animation : String = "falling"

@export var sfx_jump : AudioStreamPlayer2D

@export var air_state : State

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") and can_move):
		jump(event)

func state_process(_delta):
	if(!character.is_on_floor()):
		next_state = air_state
		playback.travel(falling_animation)

# Handle character jump
func jump(_event : InputEvent):
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
	sfx_jump.play()
