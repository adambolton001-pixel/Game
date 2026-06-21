extends Node

const CARDS := [
	"Arthur Crane confessed.",
	"In private. To the police. At Edmund's instruction.",
	"The confession was printed in every rival paper before anyone could stop it.",
	"Arthur served four years. The Ashgate Chronicle closed within six months.",
	"Councillor Hargrove was ruined by association. He died of a stroke in 1893.",
	"",
	"Edmund told himself he'd done the right thing.",
	"Most days, he believed it.",
	"",
	"Rosie grew up. She became a schoolteacher.",
	"Thomas became a journalist. He was good at it.",
	"",
	"Edmund still sets type. At a different paper now.",
	"He never mentioned Arthur Crane's name again.",
	"",
	"He keeps a lantern on his desk.",
	"Some nights it burns bright.",
	"Some nights it flickers.",
]

@onready var card_label: RichTextLabel = $CardLabel

var _card_index: int = 0

func _ready() -> void:
	card_label.text = ""
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
	var tween := create_tween()
	tween.tween_property(card_label, "modulate:a", 0.0, 0.3)
	await tween.finished
	card_label.text = CARDS[_card_index]
	var tween2 := create_tween()
	tween2.tween_property(card_label, "modulate:a", 1.0, 0.6)
