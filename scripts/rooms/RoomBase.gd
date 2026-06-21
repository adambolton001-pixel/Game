extends Node2D
class_name RoomBase

@export var room_id: String = ""
@export var ambient_track: String = ""

@onready var player_spawn: Marker2D = $PlayerSpawn

signal room_ready(room_id: String)

func _ready() -> void:
	GameState.current_room = room_id
	_restore_clue_state()
	_load_background()
	AudioManager.play_ambient(room_id)
	await get_tree().physics_frame
	room_ready.emit(room_id)

func _load_background() -> void:
	if room_id == "":
		return
	var bg_node := get_node_or_null("Background") as Sprite2D
	if not bg_node:
		return
	var path := "res://assets/backgrounds/%s.svg" % room_id
	if ResourceLoader.exists(path):
		bg_node.texture = load(path)
		bg_node.position = Vector2(960, 540)

func _restore_clue_state() -> void:
	# Hide any clue items already collected
	for child in get_children():
		if child is ClueItem and child.clue_id != "":
			if GameState.has_clue(child.clue_id):
				child.hide()

func get_spawn_position() -> Vector2:
	if player_spawn:
		return player_spawn.global_position
	return Vector2.ZERO

func transition_to(target_room: String, fade_duration: float = 0.5) -> void:
	var tree := get_tree()
	# Simple fade — SceneTransition node can be overlaid
	var tween := create_tween()
	tween.tween_property(
		CanvasLayer.new(), "modulate:a", 0.0, fade_duration
	)
	await tween.finished
	tree.change_scene_to_file("res://scenes/rooms/%s.tscn" % target_room)
