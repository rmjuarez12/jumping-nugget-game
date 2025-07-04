extends Node

@export var game_data: Dictionary = {
	"gems": 0,
	"deaths": 0
}

@export var gem_nodes: Array[bool]

@onready var player: Node = $"../MainPlayer"
@onready var panel: Panel = $HUD/Panel
@onready var all_gems: Node = $"../AllGems"
@onready var checkpoint: Marker2D = $Checkpoint
@onready var death_counter: Label = $HUD/Panel/DeathCounter/Label

func _ready() -> void:
	for i in range(all_gems.get_child_count()):
		gem_nodes.append(false)

	generate_gem_spaces()

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
		var x_pos: int = 30 * (pos_multiplier % 5)
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
		print(child.name)
		if child is Sprite2D:
			child.queue_free()
			print("removing stuff")
	
	generate_gem_spaces()
