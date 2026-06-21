extends Control

@onready var new_game_btn: Button = $VBox/NewGame
@onready var continue_btn: Button = $VBox/Continue
@onready var quit_btn: Button = $VBox/Quit

func _ready() -> void:
	new_game_btn.pressed.connect(_on_new_game)
	continue_btn.pressed.connect(_on_continue)
	quit_btn.pressed.connect(_on_quit)
	continue_btn.disabled = not GameState.has_save()

func _on_new_game() -> void:
	GameState.reset()
	LanternSystem.load_from_game_state()
	get_tree().change_scene_to_file("res://scenes/rooms/alley.tscn")

func _on_continue() -> void:
	if GameState.load_save():
		LanternSystem.load_from_game_state()
		get_tree().change_scene_to_file(
			"res://scenes/rooms/%s.tscn" % GameState.current_room
		)

func _on_quit() -> void:
	get_tree().quit()
