extends CanvasLayer
class_name HUD

@onready var inventory_btn: Button = $Buttons/InventoryBtn
@onready var journal_btn: Button = $Buttons/JournalBtn
@onready var journal_dot: Control = $Buttons/JournalBtn/Dot
@onready var inventory: Inventory = $Inventory
@onready var journal: Journal = $Journal

func _ready() -> void:
	inventory_btn.pressed.connect(inventory.toggle)
	journal_btn.pressed.connect(_toggle_journal)
	GameState.journal_updated.connect(_on_journal_updated)
	journal_dot.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused

func _on_journal_updated(_entry: String) -> void:
	journal_dot.show()

func _toggle_journal() -> void:
	journal.toggle()
	journal_dot.hide()
