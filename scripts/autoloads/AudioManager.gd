extends Node

# Audio buses: Master, Music, SFX, Ambient
# Call AudioManager.play_ambient("alley") etc.

const AMBIENT_TRACKS := {
	"alley": "res://assets/audio/ambient/alley_night.ogg",
	"hale_home": "res://assets/audio/ambient/home_interior.ogg",
	"print_shop": "res://assets/audio/ambient/press_room.ogg",
	"whitmore_street": "res://assets/audio/ambient/street_night.ogg",
	"hargrove_estate": "res://assets/audio/ambient/estate_interior.ogg",
}

const SFX := {
	"clue_found": "res://assets/audio/sfx/clue_found.ogg",
	"dialogue_click": "res://assets/audio/sfx/page_turn.ogg",
	"journal_open": "res://assets/audio/sfx/journal_open.ogg",
	"lantern_dim": "res://assets/audio/sfx/flame_flicker.ogg",
	"lantern_dark": "res://assets/audio/sfx/flame_out.ogg",
	"door_open": "res://assets/audio/sfx/door_creak.ogg",
}

@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ambient_player: AudioStreamPlayer = $AmbientPlayer
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer

var _current_ambient: String = ""

func _ready() -> void:
	GameState.flag_changed.connect(_on_flag_changed)
	LanternSystem.lantern_state_changed.connect(_on_lantern_state_changed)

func play_ambient(room_id: String, crossfade: float = 1.5) -> void:
	if room_id == _current_ambient:
		return
	_current_ambient = room_id
	var path: String = AMBIENT_TRACKS.get(room_id, "")
	if path == "" or not ResourceLoader.exists(path):
		ambient_player.stop()
		return
	var stream = load(path)
	if crossfade > 0.0 and ambient_player.playing:
		var tween := create_tween()
		tween.tween_property(ambient_player, "volume_db", -40.0, crossfade)
		await tween.finished
	ambient_player.stream = stream
	ambient_player.volume_db = -40.0
	ambient_player.play()
	var tween2 := create_tween()
	tween2.tween_property(ambient_player, "volume_db", -6.0, crossfade)

func play_sfx(sfx_id: String) -> void:
	var path: String = SFX.get(sfx_id, "")
	if path == "" or not ResourceLoader.exists(path):
		return
	sfx_player.stream = load(path)
	sfx_player.play()

func set_music_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func set_sfx_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))

func set_ambient_volume(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Ambient"), linear_to_db(value))

func _on_flag_changed(flag_name: String, _value) -> void:
	if flag_name == "opening_played":
		play_ambient("alley")

func _on_lantern_state_changed(state: LanternSystem.LanternState) -> void:
	match state:
		LanternSystem.LanternState.DARK:
			play_sfx("lantern_dark")
		LanternSystem.LanternState.DIM:
			play_sfx("lantern_dim")
