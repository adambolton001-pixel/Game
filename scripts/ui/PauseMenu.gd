extends CanvasLayer

@onready var resume_btn: Button = $Panel/VBox/Resume
@onready var save_btn: Button = $Panel/VBox/Save
@onready var main_menu_btn: Button = $Panel/VBox/MainMenu
@onready var quit_btn: Button = $Panel/VBox/Quit

func _ready() -> void:
	layer = 20
	resume_btn.pressed.connect(_on_resume)
	save_btn.pressed.connect(_on_save)
	main_menu_btn.pressed.connect(_on_main_menu)
	quit_btn.pressed.connect(_on_quit)
	get_tree().paused = false
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_toggle()

func _toggle() -> void:
	visible = not visible
	get_tree().paused = visible

func _on_resume() -> void:
	_toggle()

func _on_save() -> void:
	GameState.save()
	SteamManager.save_to_cloud(0, JSON.stringify({
		"clues": GameState.clues_collected,
		"journal": GameState.journal_entries,
		"flags": GameState.flags,
		"current_room": GameState.current_room,
		"lantern_value": GameState.lantern_value,
	}))
	save_btn.text = "Saved."
	await get_tree().create_timer(1.5).timeout
	save_btn.text = "Save Game"

func _on_main_menu() -> void:
	get_tree().paused = false
	GameState.save()
	SceneManager.go_to_file("res://scenes/main_menu.tscn")

func _on_quit() -> void:
	GameState.save()
	get_tree().quit()
