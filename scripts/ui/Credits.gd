extends Control

const CREDITS := """THE PALE LANTERN



Story & Design
[Your Name]



Programming
[Your Name]



Art & Backgrounds
[Your Name]



Music & Sound
[Composer Name]



Special Thanks
Clara.
She was right about everything.




Thank you for playing.




"""

@onready var label: RichTextLabel = $ScrollContainer/Label
@onready var scroll: ScrollContainer = $ScrollContainer

const SCROLL_SPEED := 40.0

func _ready() -> void:
	label.text = CREDITS
	label.bbcode_enabled = true
	await SceneManager.fade_in()
	await get_tree().create_timer(1.0).timeout

func _process(delta: float) -> void:
	scroll.scroll_vertical += int(SCROLL_SPEED * delta)
	if scroll.scroll_vertical >= int(scroll.get_v_scroll_bar().max_value):
		set_process(false)
		await get_tree().create_timer(3.0).timeout
		SceneManager.go_to_file("res://scenes/main_menu.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		SceneManager.go_to_file("res://scenes/main_menu.tscn")
