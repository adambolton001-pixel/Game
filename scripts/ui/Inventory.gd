extends CanvasLayer
class_name Inventory

@onready var grid: GridContainer = $Panel/ScrollContainer/Grid
@onready var detail_name: Label = $Panel/Detail/Name
@onready var detail_desc: RichTextLabel = $Panel/Detail/Description
@onready var detail_icon: TextureRect = $Panel/Detail/Icon

var _clue_data: Dictionary = {}

func _ready() -> void:
	GameState.clue_collected.connect(_on_clue_collected)
	hide()

func _on_clue_collected(clue_id: String) -> void:
	_load_clue_data(clue_id)
	_add_clue_button(clue_id)

func _load_clue_data(clue_id: String) -> void:
	var path := "res://data/clues/%s.json" % clue_id
	var file := FileAccess.open(path, FileAccess.READ)
	if not file:
		return
	var data = JSON.parse_string(file.get_as_text())
	if data is Dictionary:
		_clue_data[clue_id] = data

func _add_clue_button(clue_id: String) -> void:
	var data: Dictionary = _clue_data.get(clue_id, {})
	var btn := Button.new()
	btn.tooltip_text = data.get("name", clue_id)
	var icon_path: String = data.get("icon", "")
	if icon_path != "" and ResourceLoader.exists(icon_path):
		btn.icon = load(icon_path)
	btn.pressed.connect(func(): _show_detail(clue_id))
	grid.add_child(btn)

func _show_detail(clue_id: String) -> void:
	var data: Dictionary = _clue_data.get(clue_id, {})
	detail_name.text = data.get("name", "Unknown")
	detail_desc.text = data.get("description", "")
	var icon_path: String = data.get("icon", "")
	if icon_path != "" and ResourceLoader.exists(icon_path):
		detail_icon.texture = load(icon_path)

func toggle() -> void:
	visible = not visible
