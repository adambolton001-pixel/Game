extends CanvasLayer

# Handles all scene transitions with fade in/out.
# Usage: SceneManager.go_to("alley") or SceneManager.go_to_file("res://scenes/...")

signal transition_started
signal transition_finished

const FADE_DURATION := 0.4

@onready var overlay: ColorRect = $Overlay

var _transitioning: bool = false

func _ready() -> void:
	layer = 100
	overlay.color = Color(0, 0, 0, 0)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE

func go_to(room_id: String) -> void:
	go_to_file("res://scenes/rooms/%s.tscn" % room_id)

func go_to_file(path: String) -> void:
	if _transitioning:
		return
	_transitioning = true
	transition_started.emit()
	await _fade(1.0)
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await _fade(0.0)
	_transitioning = false
	transition_finished.emit()

func fade_in() -> void:
	await _fade(0.0)

func fade_out() -> void:
	await _fade(1.0)

func _fade(target_alpha: float) -> void:
	overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween := create_tween()
	tween.tween_property(overlay, "color:a", target_alpha, FADE_DURATION)
	await tween.finished
	if target_alpha == 0.0:
		overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
