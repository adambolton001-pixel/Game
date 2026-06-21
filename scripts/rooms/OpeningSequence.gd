extends Node
# Drives the scripted opening of the alley scene.
# Attached to the Alley room. Plays once; never repeats after flag is set.

@export var player: CharacterBody2D
@export var clara_marker: Marker2D
@export var police_marker: Marker2D
@export var rowe_npc: Node2D

signal sequence_complete

func _ready() -> void:
	if GameState.get_flag("opening_played"):
		sequence_complete.emit()
		return
	call_deferred("_play")

func _play() -> void:
	# Block player input during cinematic
	player.set_process_unhandled_input(false)
	await SceneManager.fade_in()
	await get_tree().create_timer(0.8).timeout

	# Edmund enters — walk toward the body marker
	player.move_to(clara_marker.global_position + Vector2(80, 0))
	await get_tree().create_timer(2.5).timeout

	# The realisation dialogue plays
	DialogueManager.start("alley_opening")
	await DialogueManager.dialogue_ended

	await get_tree().create_timer(0.6).timeout

	# Police arrive — Rowe NPC appears and walks to body
	if rowe_npc:
		rowe_npc.show()
	await get_tree().create_timer(1.2).timeout

	# Rowe opens dialogue
	DialogueManager.start("constable_rowe")
	await DialogueManager.dialogue_ended

	await get_tree().create_timer(0.5).timeout

	# Police clear the area — hint about Mickey Daws
	_show_caption("The police move her body. The alley empties. Someone is watching from the shadows.")
	await get_tree().create_timer(3.5).timeout
	_hide_caption()

	GameState.set_flag("opening_played", true)
	GameState.add_journal_entry("The police called it a Ripper killing. They're wrong. I know they're wrong.")
	player.set_process_unhandled_input(true)
	sequence_complete.emit()

func _show_caption(text: String) -> void:
	var lbl := _get_or_create_caption()
	lbl.text = text
	var tween := create_tween()
	tween.tween_property(lbl, "modulate:a", 1.0, 0.4)

func _hide_caption() -> void:
	var lbl := _get_or_create_caption()
	var tween := create_tween()
	tween.tween_property(lbl, "modulate:a", 0.0, 0.4)

func _get_or_create_caption() -> Label:
	var existing := get_node_or_null("Caption")
	if existing:
		return existing
	var lbl := Label.new()
	lbl.name = "Caption"
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	lbl.anchor_left = 0.1
	lbl.anchor_right = 0.9
	lbl.modulate.a = 0.0
	lbl.add_theme_font_size_override("font_size", 18)
	# Position at bottom of screen via CanvasLayer
	var cl := CanvasLayer.new()
	cl.layer = 3
	add_child(cl)
	cl.add_child(lbl)
	lbl.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	lbl.offset_bottom = -40
	return lbl
