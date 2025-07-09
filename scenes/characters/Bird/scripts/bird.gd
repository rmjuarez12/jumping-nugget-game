extends Node2D

@export var animation_player: AnimationPlayer
@export var enemy_body: Node2D
@export var enemy_sprite: Sprite2D
@onready var game_manager: Node = get_node("/root/Stage/GameManager")
@onready var point_a: Marker2D = $PointA
@onready var point_b: Marker2D = $PointB

@onready var stun_timer: Timer = $StunTimer
@onready var death_timer: Timer = $DeathTimer
var is_stunned: bool = false

@export var moving_to_point_a: bool = true

func _ready() -> void:
	animation_player.play("flying")

func _process(delta: float) -> void:
	var speed = 50 * delta

	if moving_to_point_a and not is_stunned:
		enemy_body.position = enemy_body.position.move_toward(point_a.position, speed)
		flip_sprite(point_a.position)
		if enemy_body.position == point_a.position:
			moving_to_point_a = false
	elif not moving_to_point_a and not is_stunned:
		enemy_body.position = enemy_body.position.move_toward(point_b.position, speed)
		flip_sprite(point_b.position)
		if enemy_body.position == point_b.position:
			moving_to_point_a = true

func flip_sprite(destination_position: Vector2) -> void:
	if destination_position.x < enemy_body.position.x:
		enemy_sprite.flip_h = false
	else:
		enemy_sprite.flip_h = true

func _on_hitbox_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer" and not is_stunned):
		game_manager.player.state_machine.set_death_state()
		body.velocity = Vector2(0, 0)
		death_timer.start()

func _on_hurtbox_body_entered(body:Node2D) -> void:
	var current_state = game_manager.player.state_machine.current_state.name

	if (body.name == "MainPlayer" and current_state != "Death"):
		animation_player.play("stun")
		stun_timer.start()
		is_stunned = true

		if Input.is_action_pressed("jump"):
			body.velocity.y = -800
		else:
			body.velocity.y = -300

func _on_death_timer_timeout() -> void:
	game_manager.player_died()
	death_timer.stop()

func _on_stun_timer_timeout() -> void:
	is_stunned = false
	stun_timer.stop()
	animation_player.play("flying")
	
