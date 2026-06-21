extends Node
# Reads the "ending" flag set during arthur_crane_final dialogue
# and plays the appropriate ending sequence.

signal ending_complete

var _ending: String = ""

func _ready() -> void:
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _on_dialogue_ended(dialogue_id: String) -> void:
	if dialogue_id == "arthur_crane_final":
		_ending = GameState.get_flag("ending", "bright")
		call_deferred("_play_ending")

func _play_ending() -> void:
	await get_tree().create_timer(1.2).timeout
	match _ending:
		"bright":
			SceneManager.go_to_file("res://scenes/endings/ending_bright.tscn")
			SteamManager.unlock_achievement("ENDING_BRIGHT")
		"mid":
			SceneManager.go_to_file("res://scenes/endings/ending_mid.tscn")
			SteamManager.unlock_achievement("ENDING_MID")
		"dark":
			SceneManager.go_to_file("res://scenes/endings/ending_dark.tscn")
			SteamManager.unlock_achievement("ENDING_DARK")
