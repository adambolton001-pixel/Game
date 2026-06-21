extends Node

# GodotSteam integration stub.
# When GodotSteam plugin is installed, replace _steam_available check
# with Steam.steamInit() and wire up the real calls.

var _steam_available := false

func _ready() -> void:
	if Engine.has_singleton("Steam"):
		var init_result = Engine.get_singleton("Steam").steamInit()
		_steam_available = init_result.get("status", false)
		if _steam_available:
			print("SteamManager: Steam initialised")
		else:
			push_warning("SteamManager: Steam init failed — %s" % str(init_result))
	else:
		push_warning("SteamManager: Steam singleton not found — running without Steam")

func _process(_delta: float) -> void:
	if _steam_available:
		Engine.get_singleton("Steam").steamworksUpdate()

func unlock_achievement(achievement_id: String) -> void:
	if not _steam_available:
		return
	var steam = Engine.get_singleton("Steam")
	steam.setAchievement(achievement_id)
	steam.storeStats()

func save_to_cloud(slot: int, data: String) -> void:
	if not _steam_available:
		return
	var filename := "save_slot_%d.json" % slot
	Engine.get_singleton("Steam").fileWrite(filename, data)

func load_from_cloud(slot: int) -> String:
	if not _steam_available:
		return ""
	var filename := "save_slot_%d.json" % slot
	var steam = Engine.get_singleton("Steam")
	if steam.fileExists(filename):
		return steam.fileRead(filename)
	return ""

func is_available() -> bool:
	return _steam_available
