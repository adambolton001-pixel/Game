extends Area2D
class_name Interactable

@export var interaction_label: String = "Examine"
@export var dialogue_id: String = ""
@export var clue_id: String = ""
@export var one_shot: bool = false

var _used: bool = false

signal interacted

func _ready() -> void:
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_input_event(_viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if one_shot and _used:
			return
		_used = true
		interacted.emit()
		_on_interact()

func _on_interact() -> void:
	if clue_id != "":
		GameState.collect_clue(clue_id)
	if dialogue_id != "":
		DialogueManager.start(dialogue_id)

func _on_mouse_entered() -> void:
	pass

func _on_mouse_exited() -> void:
	pass

func can_interact() -> bool:
	return not (one_shot and _used)
