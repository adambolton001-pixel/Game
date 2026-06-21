extends CanvasLayer
class_name LanternMeter

@onready var flame: TextureProgressBar = $Flame
@onready var flicker_timer: Timer = $FlickerTimer

const DARK_COLOR := Color(0.8, 0.2, 0.1)
const DIM_COLOR := Color(0.9, 0.6, 0.1)
const BRIGHT_COLOR := Color(1.0, 0.95, 0.6)

func _ready() -> void:
	LanternSystem.lantern_changed.connect(_on_lantern_changed)
	LanternSystem.lantern_state_changed.connect(_on_state_changed)
	_refresh()

func _on_lantern_changed(_value: int) -> void:
	_refresh()

func _on_state_changed(state: LanternSystem.LanternState) -> void:
	match state:
		LanternSystem.LanternState.DARK:
			flicker_timer.start()
		_:
			flicker_timer.stop()
			flame.modulate.a = 1.0

func _refresh() -> void:
	flame.value = LanternSystem.get_normalised() * 100.0
	var state := LanternSystem.get_state()
	match state:
		LanternSystem.LanternState.BRIGHT:
			flame.tint_progress = BRIGHT_COLOR
		LanternSystem.LanternState.DIM:
			flame.tint_progress = DIM_COLOR
		LanternSystem.LanternState.DARK:
			flame.tint_progress = DARK_COLOR

func _on_flicker_timer_timeout() -> void:
	# Subtle flicker effect when lantern is dark
	var tween := create_tween()
	tween.tween_property(flame, "modulate:a", randf_range(0.4, 0.85), 0.08)
	tween.tween_property(flame, "modulate:a", 1.0, 0.12)
