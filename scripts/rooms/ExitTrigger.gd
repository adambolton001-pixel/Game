extends Area2D

@export var target_room: String = ""
@export var requires_flag: String = ""
@export var requires_flag_value: bool = true
@export var blocked_dialogue: String = ""

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	if requires_flag != "":
		var val = GameState.get_flag(requires_flag)
		if val != requires_flag_value:
			if blocked_dialogue != "":
				DialogueManager.start(blocked_dialogue)
			return
	if target_room != "":
		SceneManager.go_to(target_room)
