extends Node

@export var game_data: Dictionary = {
	"gems": 0,
	"deaths": 0,
	"timeMins": 0,
	"timeSecs": 0
}

@export var gem_nodes: Array[bool]

@export var intro_dialogue: DialogueResource

@onready var player: Node = $"../MainPlayer"
@onready var panel: Panel = $HUD/Panel
@onready var all_gems: Node = $"../AllGems"
@onready var checkpoint: Marker2D = $"../Checkpoint"
@onready var death_counter: Label = $HUD/Panel/DeathCounter/Label
@onready var stage_timer_counter: Label = $HUD/Panel/Timer/Label
@onready var stage_timer: Timer = $StageTimer

func _ready() -> void:
	print("has reloaded: ", DialogueState.has_reloaded)
	for i in range(all_gems.get_child_count()):
		gem_nodes.append(false)

	generate_gem_spaces()

	if intro_dialogue and not DialogueState.has_reloaded:
		player.state_machine.current_state.can_move = false
		await get_tree().create_timer(1).timeout

		DialogueManager.show_dialogue_balloon(intro_dialogue, "start")

func player_died() -> void:
	game_data["deaths"] += 1
	death_counter.text = "x " + str(game_data["deaths"])
	player.position = checkpoint.position
	player.state_machine.set_default_state()

# Generates the gem spaces on the HUD
func generate_gem_spaces() -> void:
	# Show an icon for all available gems
	for i in range(gem_nodes.size()):
		
		# Choose which texture to use
		var gem_texture = "res://scenes/misc/GameManager/assets/empty-gem.png"
		if(gem_nodes[i]):
			gem_texture = "res://scenes/misc/GameManager/assets/full-gem.png"

		# Create a new gem sprite in the HUD panel
		var gem_sprite = Sprite2D.new ()
		gem_sprite.texture = load(gem_texture)
		gem_sprite.scale = Vector2(1.5, 1.5)
		
		# Set the proper position for it
		var pos_multiplier: int = i + 1
		var x_pos: int = 30 * (pos_multiplier % 7)
		gem_sprite.position = Vector2(x_pos, 65)
		
		# Add it to the panel
		panel.add_child(gem_sprite)

# Handle what happens when a gem is collected
func add_gem(gem: Area2D) -> void:
	# Get the gem number from the gem's name
	var gem_name : String = gem.name
	var gem_num: int = gem_name.right(gem_name.length()-9).to_int()

	# Insert the gem into the gem_nodes array at the correct index
	gem_nodes[gem_num - 1] = true
	game_data["gems"] += 1

	# Re-generate the gem spaces to reflect the new gem. Clear all gem spaces before.
	for child in panel.get_children():
		if child is Sprite2D:
			child.queue_free()
	
	generate_gem_spaces()


func _on_stage_timer_timeout() -> void:
	game_data["timeSecs"] += 1

	var seconds = game_data["timeSecs"]

	if seconds >= 60:
		game_data["timeMins"] += 1
		game_data["timeSecs"] = 0

	var minutes = game_data["timeMins"]

	if seconds < 10:
		seconds = "0" + str(seconds)
	else:
		seconds = str(seconds)

	if minutes < 10:
		minutes = "0" + str(minutes)
	else:
		minutes = str(minutes)

	stage_timer_counter.text = minutes + ":" + seconds

	stage_timer.start()

func _stop_stage_timer() -> void:
	stage_timer.stop()

func _start_stage_timer() -> void:
	stage_timer.start()
