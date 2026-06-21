extends Interactable
class_name ClueItem

@export var display_name: String = ""
@export var description: String = ""
@export var icon_path: String = ""
@export var journal_entry: String = ""

func _on_interact() -> void:
	super._on_interact()
	if journal_entry != "":
		GameState.add_journal_entry(journal_entry)
	_hide_from_world()

func _hide_from_world() -> void:
	# Mark collected in flags so room doesn't respawn it on reload
	GameState.set_flag("clue_picked_%s" % clue_id, true)
	hide()
	set_process(false)
	set_physics_process(false)

func _ready() -> void:
	super._ready()
	# If already collected, hide immediately
	if clue_id != "" and GameState.has_clue(clue_id):
		_hide_from_world()
