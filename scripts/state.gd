extends Node

class_name State

@export var can_move : bool = true
@export var disable_gravity : bool = false

var character : CharacterBody2D
var next_state : State
var playback : AnimationNodeStateMachinePlayback

func state_process(_delta):
	pass

func state_input(_event : InputEvent):
	pass

func on_enter():
	pass
	
func on_exit():
	pass
