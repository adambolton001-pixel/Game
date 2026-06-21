extends Node

# Lantern value: positive = light, negative = dark
# Range: -10 (fully dark) to +10 (fully light)
const MIN_VALUE := -10
const MAX_VALUE := 10

enum LanternState { BRIGHT, DIM, DARK }

signal lantern_changed(new_value: int)
signal lantern_state_changed(new_state: LanternState)

var _value: int = 0:
	set(v):
		var prev_state := get_state()
		_value = clampi(v, MIN_VALUE, MAX_VALUE)
		GameState.lantern_value = _value
		lantern_changed.emit(_value)
		var new_state := get_state()
		if new_state != prev_state:
			lantern_state_changed.emit(new_state)
			_on_state_changed(new_state)

func shift(amount: int) -> void:
	_value += amount

func get_value() -> int:
	return _value

func get_state() -> LanternState:
	if _value >= 4:
		return LanternState.BRIGHT
	elif _value >= -3:
		return LanternState.DIM
	else:
		return LanternState.DARK

func get_normalised() -> float:
	return float(_value - MIN_VALUE) / float(MAX_VALUE - MIN_VALUE)

func load_from_game_state() -> void:
	_value = GameState.lantern_value

func _on_state_changed(state: LanternState) -> void:
	match state:
		LanternState.DARK:
			GameState.add_journal_entry("I can feel myself changing. Is this what Clara would have wanted?")
