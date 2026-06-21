extends Node2D

@onready var arthur: NPC = $ArthurCrane

func _ready() -> void:
	_update_arthur_dialogue()

func _update_arthur_dialogue() -> void:
	# Progress Arthur's dialogue based on story flags
	if GameState.get_flag("thomas_found_letter"):
		arthur.set_dialogue("arthur_crane_final")
	elif GameState.get_flag("challenged_hargrove"):
		arthur.set_dialogue("arthur_crane_02")
	else:
		arthur.set_dialogue("arthur_crane_01")
