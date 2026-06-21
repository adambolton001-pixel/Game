extends Node

const SAVE_PATH := "user://save.json"

var clues_collected: Array[String] = []
var journal_entries: Array[String] = []
var flags: Dictionary = {}
var current_room: String = "alley"
var lantern_value: int = 0

signal clue_collected(clue_id: String)
signal journal_updated(entry: String)
signal flag_changed(flag_name: String, value)

func set_flag(flag_name: String, value) -> void:
	flags[flag_name] = value
	flag_changed.emit(flag_name, value)

func get_flag(flag_name: String, default = null):
	return flags.get(flag_name, default)

func collect_clue(clue_id: String) -> void:
	if clue_id in clues_collected:
		return
	clues_collected.append(clue_id)
	clue_collected.emit(clue_id)

func has_clue(clue_id: String) -> bool:
	return clue_id in clues_collected

func add_journal_entry(entry: String) -> void:
	if entry in journal_entries:
		return
	journal_entries.append(entry)
	journal_updated.emit(entry)

func save() -> void:
	var data := {
		"clues": clues_collected,
		"journal": journal_entries,
		"flags": flags,
		"current_room": current_room,
		"lantern_value": lantern_value,
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))

func load_save() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return false
	var result: Variant = JSON.parse_string(file.get_as_text())
	if not result is Dictionary:
		return false
	clues_collected = result.get("clues", [])
	journal_entries = result.get("journal", [])
	flags = result.get("flags", {})
	current_room = result.get("current_room", "alley")
	lantern_value = result.get("lantern_value", 0)
	return true

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func reset() -> void:
	clues_collected = []
	journal_entries = []
	flags = {}
	current_room = "alley"
	lantern_value = 0
