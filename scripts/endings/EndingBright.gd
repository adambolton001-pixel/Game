extends Node

const CARDS := [
	"Edmund walked to the offices of every newspaper in London that night.",
	"By morning, Arthur Crane's name was on every front page.",
	"Constable Rowe was dismissed from the force. Councillor Hargrove resigned his seat the following week.",
	"The Whitmore Street tenements were inspected. Hargrove's properties were condemned.",
	"Arthur Crane was tried for the murder of Clara Hale. He was convicted.",
	"He was hanged on a Tuesday. Edmund did not attend.",
	"",
	"Rosie still asks about her mother sometimes.",
	"Thomas became a journalist.",
	"Edmund still sets type. He works nights.",
	"He keeps a lantern on his desk.",
	"It is always lit.",
]

@onready var card_label: RichTextLabel = $CardLabel
@onready var continue_hint: Label = $ContinueHint

var _card_index: int = 0

func _ready() -> void:
	SteamManager.unlock_achievement("ENDING_BRIGHT")
	card_label.text = ""
	continue_hint.text = "[ click ]"
	await SceneManager.fade_in()
	_show_card()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_card_index += 1
		if _card_index >= CARDS.size():
			SceneManager.go_to_file("res://scenes/credits.tscn")
		else:
			_show_card()

func _show_card() -> void:
	var text: String = CARDS[_card_index]
	var tween := create_tween()
	tween.tween_property(card_label, "modulate:a", 0.0, 0.3)
	await tween.finished
	card_label.text = text
	var tween2 := create_tween()
	tween2.tween_property(card_label, "modulate:a", 1.0, 0.6)
