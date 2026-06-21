extends Node2D

@onready var opening: Node = $OpeningSequence
@onready var player: CharacterBody2D = $Player
@onready var clara_marker: Marker2D = $ClaraMarker
@onready var rowe_npc: Node2D = $ConstableRowe

func _ready() -> void:
	opening.player = player
	opening.clara_marker = clara_marker
	opening.rowe_npc = rowe_npc
	opening.sequence_complete.connect(_on_sequence_complete)

func _on_sequence_complete() -> void:
	# After opening, Arthur tip unlocks print shop direction
	if not GameState.get_flag("arthur_intro_done"):
		GameState.set_flag("arthur_intro_done", true)
