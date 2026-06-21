extends Node2D

@onready var thomas_normal: Area2D = $Thomas
@onready var thomas_letter: Area2D = $ThomasWithLetter

func _ready() -> void:
	# Thomas shows the letter scene only once he's found it
	# Triggered externally via flag after Act 4 event
	var letter_found: bool = GameState.get_flag("thomas_found_letter", false)
	thomas_normal.visible = not letter_found
	thomas_letter.visible = letter_found

	GameState.flag_changed.connect(_on_flag_changed)

func _on_flag_changed(flag_name: String, value) -> void:
	if flag_name == "thomas_found_letter" and value == true:
		thomas_normal.hide()
		thomas_letter.show()
