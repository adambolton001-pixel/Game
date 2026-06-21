extends CanvasLayer
class_name Journal

@onready var entry_list: VBoxContainer = $Panel/ScrollContainer/Entries
@onready var notification_dot: Control = $NotificationDot

var _unread_count: int = 0

func _ready() -> void:
	GameState.journal_updated.connect(_on_journal_updated)
	# Load any existing entries (after a save load)
	for entry in GameState.journal_entries:
		_add_entry_label(entry)
	hide()

func _on_journal_updated(entry: String) -> void:
	_add_entry_label(entry)
	_unread_count += 1
	notification_dot.show()

func _add_entry_label(text: String) -> void:
	var lbl := RichTextLabel.new()
	lbl.bbcode_enabled = true
	lbl.text = "— " + text
	lbl.fit_content = true
	lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	entry_list.add_child(lbl)
	entry_list.move_child(lbl, 0)

func toggle() -> void:
	visible = not visible
	if visible:
		_unread_count = 0
		notification_dot.hide()
