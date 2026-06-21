# 2D Mystery Adventure Game — Implementation Plan

## Stack
- **Engine:** Godot 4 (GDScript)
- **Platform target:** Steam (Windows + Linux exports)
- **Steam integration:** GodotSteam plugin

---

## Project Structure

```
Game/
├── project.godot
├── addons/
│   └── godotsteam/          # Steam SDK integration plugin
├── scenes/
│   ├── main_menu.tscn
│   ├── game.tscn            # Root game scene
│   ├── rooms/               # Individual locations (kitchen, library, etc.)
│   ├── ui/
│   │   ├── dialogue.tscn    # Dialogue box + speaker portrait
│   │   ├── inventory.tscn   # Clue/item panel
│   │   └── journal.tscn     # Notes/deduction board
│   └── player/
│       └── player.tscn
├── scripts/
│   ├── autoloads/
│   │   ├── GameState.gd     # Global save state (singleton)
│   │   ├── DialogueManager.gd
│   │   └── SteamManager.gd  # Achievements, cloud saves
│   ├── objects/
│   │   ├── Interactable.gd  # Base class for clickable objects
│   │   ├── NPC.gd
│   │   └── ClueItem.gd
│   └── ui/
│       ├── DialogueBox.gd
│       ├── Inventory.gd
│       └── Journal.gd
├── assets/
│   ├── sprites/
│   ├── backgrounds/
│   ├── audio/
│   └── fonts/
└── data/
    ├── dialogue/            # JSON files for all dialogue trees
    └── clues/               # JSON definitions for clues/items
```

---

## Core Systems (Build Order)

### Phase 1 — Project scaffold
1. Initialize Godot 4 project (`project.godot`, folder structure)
2. Configure autoloads (GameState, DialogueManager, SteamManager)
3. Set up export presets for Windows + Linux

### Phase 2 — Player & Rooms
4. Player scene: point-and-click movement (click to move, pathfinding via NavigationAgent2D)
5. Room base scene: background + navigation mesh + entry/exit points
6. Room transition system (fade in/out between scenes)
7. Two starter rooms to prove the system works

### Phase 3 — Interactables & Dialogue
8. `Interactable` base class (clickable, highlight on hover, trigger dialogue/event)
9. Dialogue system: reads from JSON, shows speaker name + portrait, advances with click
10. NPC class extending Interactable (has dialogue tree, can give clues)

### Phase 4 — Inventory & Journal
11. Clue pickup system (items added to inventory on examine)
12. Inventory UI panel (icon grid, click to inspect)
13. Journal UI (list of notes/deductions, auto-updated when clues collected)

### Phase 5 — Steam Integration
14. Install GodotSteam plugin
15. `SteamManager` autoload: init Steam, basic achievement unlock helper
16. Steam cloud save (sync GameState to Steam Remote Storage)
17. At least one achievement wired up as proof of concept

### Phase 6 — Main Menu & Polish
18. Main menu (New Game, Continue, Quit)
19. Settings screen (volume, fullscreen toggle)
20. Pause menu
21. Save/load system (JSON file + Steam cloud)

---

## Key Technical Decisions

| Decision | Choice | Reason |
|---|---|---|
| Movement | Point-and-click | Classic for mystery/adventure genre |
| Dialogue storage | JSON files | Easy to edit without touching code |
| Save format | JSON + Steam cloud | Human-readable, easy to extend |
| Steam SDK | GodotSteam 4.x | Best-maintained Godot/Steam bridge |

---

## Steam Publishing Checklist (later)
- [ ] Steam Developer account + app ID
- [ ] Store page assets (capsule art, screenshots, trailer)
- [ ] Steamworks SDK integrated and tested
- [ ] At least 1 achievement (Steam requires this)
- [ ] Windows + Linux build exports verified
- [ ] Steam build uploaded via SteamPipe CLI

---

## What We Build First (this session)
1. Folder structure + `project.godot`
2. All GDScript autoloads (stubs ready to fill in)
3. Player scene with click-to-move
4. One sample room with one interactable NPC and a dialogue JSON
5. Dialogue box UI
6. `SteamManager` stub (safe no-op when Steam not running)
