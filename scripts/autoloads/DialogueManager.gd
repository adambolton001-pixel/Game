extends Node

signal dialogue_started(dialogue_id: String)
signal dialogue_line_shown(speaker: String, text: String, portrait: String)
signal choices_shown(choices: Array)
signal dialogue_ended(dialogue_id: String)

var _current_dialogue: Dictionary = {}
var _current_node_id: String = ""
var _dialogue_id: String = ""
var _active: bool = false

func is_active() -> bool:
	return _active

func start(dialogue_id: String) -> void:
	var path := "res://data/dialogue/%s.json" % dialogue_id
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		push_error("DialogueManager: cannot open %s" % path)
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if not parsed is Dictionary:
		push_error("DialogueManager: invalid JSON in %s" % path)
		return
	_current_dialogue = parsed
	_dialogue_id = dialogue_id
	_active = true
	dialogue_started.emit(dialogue_id)
	_go_to(_current_dialogue.get("start_node", "start"))

func advance() -> void:
	if not _active:
		return
	var node := _get_current_node()
	if not node:
		end()
		return
	# Nodes with choices don't auto-advance — they wait for choose()
	if node.has("choices"):
		return
	var next: String = node.get("next", "")
	if next == "" or next == "end":
		end()
	else:
		_go_to(next)

func choose(choice_index: int) -> void:
	if not _active:
		return
	var node := _get_current_node()
	if not node or not node.has("choices"):
		return
	var choices: Array = node["choices"]
	if choice_index < 0 or choice_index >= choices.size():
		return
	var choice: Dictionary = choices[choice_index]
	# Apply lantern shift if defined
	var lantern_shift: int = choice.get("lantern", 0)
	if lantern_shift != 0:
		LanternSystem.shift(lantern_shift)
	# Set flags if defined
	for flag_entry in choice.get("set_flags", []):
		GameState.set_flag(flag_entry["name"], flag_entry["value"])
	var next: String = choice.get("next", "end")
	if next == "end":
		end()
	else:
		_go_to(next)

func end() -> void:
	_active = false
	dialogue_ended.emit(_dialogue_id)
	_current_dialogue = {}
	_current_node_id = ""

func _go_to(node_id: String) -> void:
	# Check condition flags before showing node
	var node := _find_node(node_id)
	if not node:
		push_error("DialogueManager: node '%s' not found in '%s'" % [node_id, _dialogue_id])
		end()
		return
	# Skip node if condition not met
	if node.has("requires_flag"):
		var req: Dictionary = node["requires_flag"]
		var actual = GameState.get_flag(req["name"])
		if actual != req.get("value", true):
			var skip_to: String = node.get("skip_to", "end")
			_go_to(skip_to)
			return
	_current_node_id = node_id
	# Collect clue if defined
	if node.has("collect_clue"):
		GameState.collect_clue(node["collect_clue"])
	# Add journal entry if defined
	if node.has("journal_entry"):
		GameState.add_journal_entry(node["journal_entry"])
	var speaker: String = node.get("speaker", "")
	var text: String = node.get("text", "")
	var portrait: String = node.get("portrait", "")
	dialogue_line_shown.emit(speaker, text, portrait)
	if node.has("choices"):
		# Filter choices by flag conditions
		var valid_choices: Array = []
		for c in node["choices"]:
			if c.has("requires_flag"):
				var req: Dictionary = c["requires_flag"]
				if GameState.get_flag(req["name"]) != req.get("value", true):
					continue
			valid_choices.append(c)
		choices_shown.emit(valid_choices)

func _get_current_node() -> Dictionary:
	return _find_node(_current_node_id)

func _find_node(node_id: String) -> Dictionary:
	for node in _current_dialogue.get("nodes", []):
		if node.get("id", "") == node_id:
			return node
	return {}
