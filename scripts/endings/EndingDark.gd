extends Node
# The lantern goes out.

const CARDS := [
	"Edmund walked home.",
	"",
	"Rosie ran to the door.",
	"",
	"She stopped when she saw his face.",
	"",
	"Thomas watched from the stairs.",
	"",
	"Nobody spoke.",
	"",
	"The lantern Edmund carried had gone out somewhere on the walk home.",
	"He didn't notice.",
	"",
	"",
	"Arthur Crane was found the following morning.",
	"The police called it a Ripper killing.",
	"",
	"They closed the case in minutes.",
]

@onready var card_label: RichTextLabel = $CardLabel
@onready var lantern_image: TextureRect = $LanternImage

var _card_index: int = 0
var _showed_lantern: bool = false

func _ready() -> void:
	card_label.text = ""
	await SceneManager.fade_in()
	await get_tree().create_timer(2.0).timeout
	_show_card()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_card_index += 1
		if _card_index >= CARDS.size():
			_show_final()
		else:
			_show_card()

func _show_card() -> void:
	var tween := create_tween()
	tween.tween_property(card_label, "modulate:a", 0.0, 0.4)
	await tween.finished
	card_label.text = CARDS[_card_index]
	# On "The lantern Edmund carried had gone out" card - flicker and dim the UI
	if _card_index == 10 and not _showed_lantern:
		_showed_lantern = true
		_extinguish_lantern()
	var tween2 := create_tween()
	tween2.tween_property(card_label, "modulate:a", 1.0, 0.8)

func _extinguish_lantern() -> void:
	# Slowly dim the whole screen - the world gets darker as the lantern dies
	var tween := create_tween()
	tween.tween_property(get_tree().get_root(), "canvas_modulate", Color(0.2, 0.15, 0.1), 3.0)
	AudioManager.play_sfx("lantern_dark")

func _show_final() -> void:
	# Fade to complete black. Silence.
	var tween := create_tween()
	tween.tween_property(card_label, "modulate:a", 0.0, 1.0)
	await tween.finished
	await get_tree().create_timer(3.0).timeout
	SceneManager.go_to_file("res://scenes/credits.tscn")
