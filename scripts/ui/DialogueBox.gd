extends CanvasLayer
class_name DialogueBox

@onready var panel: PanelContainer = $Panel
@onready var speaker_label: Label = $Panel/VBox/Speaker
@onready var text_label: RichTextLabel = $Panel/VBox/Text
@onready var portrait: TextureRect = $Panel/HBox/Portrait
@onready var choices_container: VBoxContainer = $Panel/VBox/Choices
@onready var continue_hint: Label = $Panel/VBox/ContinueHint

const TYPEWRITER_SPEED := 0.03
var _typing: bool = false
var _full_text: String = ""
var _choice_buttons: Array[Button] = []

func _ready() -> void:
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_line_shown.connect(_on_line_shown)
	DialogueManager.choices_shown.connect(_on_choices_shown)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if _typing:
			_finish_typing()
		elif choices_container.visible:
			pass # Wait for choice button press
		else:
			DialogueManager.advance()

func _on_dialogue_started(_id: String) -> void:
	show()
	choices_container.hide()
	continue_hint.show()

func _on_line_shown(speaker: String, text: String, portrait_key: String) -> void:
	speaker_label.text = speaker
	_clear_choices()
	choices_container.hide()
	continue_hint.show()
	_load_portrait(portrait_key)
	_typewrite(text)

func _on_choices_shown(choices: Array) -> void:
	if _typing:
		_finish_typing()
	continue_hint.hide()
	choices_container.show()
	_clear_choices()
	for i in choices.size():
		var choice: Dictionary = choices[i]
		var btn := Button.new()
		btn.text = choice.get("text", "...")
		var idx := i
		btn.pressed.connect(func(): DialogueManager.choose(idx))
		choices_container.add_child(btn)
		_choice_buttons.append(btn)

func _on_dialogue_ended(_id: String) -> void:
	hide()
	_clear_choices()

func _typewrite(text: String) -> void:
	_full_text = text
	text_label.text = ""
	_typing = true
	var i := 0
	while i <= text.length():
		if not _typing:
			break
		text_label.text = text.substr(0, i)
		i += 1
		await get_tree().create_timer(TYPEWRITER_SPEED).timeout
	_typing = false
	text_label.text = _full_text

func _finish_typing() -> void:
	_typing = false
	text_label.text = _full_text

func _clear_choices() -> void:
	for btn in _choice_buttons:
		btn.queue_free()
	_choice_buttons.clear()

func _load_portrait(key: String) -> void:
	if key == "":
		portrait.texture = null
		return
	var path := "res://assets/sprites/portraits/%s.png" % key
	if ResourceLoader.exists(path):
		portrait.texture = load(path)
	else:
		portrait.texture = null
