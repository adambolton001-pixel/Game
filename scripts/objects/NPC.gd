extends Interactable
class_name NPC

@export var npc_name: String = ""
@export var idle_animation: String = "idle"

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var current_dialogue_id: String = ""

func _ready() -> void:
	super._ready()
	if sprite and idle_animation != "":
		sprite.play(idle_animation)
	current_dialogue_id = dialogue_id
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_interact() -> void:
	if DialogueManager.is_active():
		return
	var resolved_id := _resolve_dialogue_id()
	if resolved_id != "":
		DialogueManager.start(resolved_id)

func _resolve_dialogue_id() -> String:
	# Check for flag-gated dialogue variants
	# Convention: dialogue files named <base>_<flag>.json take priority
	# when the matching flag is set
	return current_dialogue_id

func set_dialogue(new_id: String) -> void:
	current_dialogue_id = new_id

func _on_dialogue_ended(_id: String) -> void:
	pass
