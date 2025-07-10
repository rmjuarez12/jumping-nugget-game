extends Area2D

@export var dialogue: DialogueResource
@onready var checkpoint = get_tree().get_root().get_node("Stage/Checkpoint")

func _on_body_entered(body:Node2D) -> void:
	if (body.name == "MainPlayer" and not DialogueState.has_reloaded):
		DialogueManager.show_dialogue_balloon(dialogue, "start")
		checkpoint.position = position
		queue_free()

