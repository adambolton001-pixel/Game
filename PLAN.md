# The Pale Lantern — Full Game Plan

## Game Overview
- **Title:** The Pale Lantern
- **Player character:** Edmund Hale, a newspaper typesetter
- **Genre:** Dark atmospheric Victorian murder mystery
- **Setting:** A London-style Victorian city — foggy streets, gaslit alleys, gothic architecture
- **Premise:** Edmund's wife Clara is murdered in an alley and staged to look like a Jack the Ripper copycat killing. The police dismiss it immediately. Edmund, an ordinary man with no authority, investigates alone — and slowly realises the killer has been guiding his investigation from the very beginning.
- **Tone:** Dark, moody, gothic — tense atmosphere, morally complex characters, real stakes
- **Steam target:** Windows + Linux

---

## The Hale Family
- **Edmund Hale** — typesetter at the Ashgate Chronicle. Quiet, observant, not a fighter. Grief and desperation unlock something darker in him.
- **Clara Hale (deceased)** — Edmund's wife. Was collecting testimonies about unsafe tenement housing conditions. Murdered and staged as a Ripper killing to silence her.
- **Rosie Hale, age 6** — too young to understand. Keeps asking when mama is coming home. Edmund's anchor to his humanity.
- **Thomas Hale, age 14** — old enough to see his father unravelling. Wants to help. Edmund pushes him away. Thomas finds the critical clue in Act 4 by going somewhere he was told never to go.

---

## The Morality System — "The Lantern"
Edmund carries a lantern (ties into the title). It represents his soul — how much of himself he's burning through to find the truth.

- **Cruel/desperate choices** → dim the lantern
- **Restrained/compassionate choices** → keep it bright
- **Rosie reacts** to how Edmund is changing — she's the most visible mirror of his soul
- **Thomas notices** and starts keeping his distance if Edmund goes too dark
- **NPCs in the neighbourhood** pull back if Edmund becomes feared rather than trusted
- **Three possible endings** based on lantern state when Edmund confronts Arthur:
  - Bright: Edmund turns Arthur in through the press — destroys him legally. Justice for Clara.
  - Mid: Edmund blackmails Arthur into a public confession. Justice, but at a cost.
  - Dark: Edmund does to Arthur what Arthur did to Clara. The final line of the game — Rosie asks Thomas "is papa coming home?" The lantern goes out. Edmund has become what he hunted. The game asks: is there a difference between him and Arthur now? Both decided someone's life was worth less than what they were protecting. Arthur protected the paper. Edmund protected his grief.

### Example Morality Choices
| Situation | Light | Dark |
|---|---|---|
| Mickey Daws (alley criminal) | Bribe or find leverage | Beat and threaten his family |
| Scared tenement witness | Earn trust slowly | Grab and intimidate |
| Corrupt constable | Expose publicly | Blackmail privately |
| Silas Webb (wrong suspect) | Apologise, try to repair damage | Leave him destroyed |
| Arthur Crane (endgame) | Turn him in | The lantern goes out |

---

## Full Cast of Characters

| Character | Role | Notes |
|---|---|---|
| Edmund Hale | Player character | Typesetter, grieving husband |
| Clara Hale | Victim | Already dead at game start |
| Rosie Hale | Edmund's daughter, age 6 | Emotional anchor |
| Thomas Hale | Edmund's son, age 14 | Finds the key clue in Act 4 |
| Arthur Crane | Editor of the Ashgate Chronicle / **THE KILLER** | Edmund's mentor, never suspected until the end |
| Mickey Daws | Petty criminal, runs the alley | First morality choice, has one piece of the puzzle |
| Councillor Hargrove | City councillor, owns the tenement buildings | Red herring suspect #1 — corrupt but not the killer |
| Silas Webb | Rival journalist, obsessed with Ripper coverage | Red herring suspect #2 — knows too much about the killings |
| The Tenement Woman | Clara's contact in Whitmore Street | Passes information to Edmund when she trusts him |
| Constable Rowe | The officer who closed Clara's case | Corrupt, knows more than he says |

---

## The Mystery Structure — Five Layers of Misdirection

Arthur Crane appears to be Edmund's greatest ally throughout the game. He gives tips, covers for Edmund at work, sits with Rosie. The player never suspects him — and that's the point. Every tip Arthur gives is real but steers Edmund away from the truth. On a replay, you can see exactly how he did it.

### Layer 1 — The Obvious (Demo, ~20 min)
- Edmund finds Clara in the alley
- Police dismiss it as another Ripper copycat — case closed in minutes
- Edmund notices something wrong at the scene — a detail that doesn't match the Ripper's known pattern (only a typesetter who's been setting those stories for months would catch it)
- He finds Mickey Daws, who controls the alley — **first morality choice**
- Mickey reveals a well-dressed man was seen near the alley that night
- Demo ends with Edmund finding a note Clara had hidden. Title card: *The Pale Lantern.*

### Layer 2 — The Councillor (Act 2)
- Clara's charity contacts lead Edmund to Whitmore Street tenements
- A woman there reveals Clara was collecting testimonies against Councillor Hargrove
- A second copycat murder occurs — another woman from the same neighbourhood
- Hargrove becomes the prime suspect: corrupt, powerful, motive to silence witnesses
- Edmund investigates Hargrove aggressively

### Layer 3 — The Journalist (Act 3)
- Edmund confronts Hargrove — rattled but not the killer
- Silas Webb (rival journalist) warns Edmund off in a way that feels threatening
- Webb has covered every Ripper killing in obsessive detail — he knows things that weren't printed
- A third murder. Webb becomes Edmund's new prime suspect
- Edmund tears Webb's life apart

### Layer 4 — The Collapse (Act 4)
- Edmund is wrong about Webb. Webb is broken by the accusations (cost depends on morality choices)
- Arthur has been a constant presence — food, the kids, gentle moral warnings to Edmund
- Thomas goes to the print shop at night looking for his father
- Thomas finds Clara's letter in Arthur's locked desk — she wrote to the paper about Hargrove's tenements weeks before she died. Arthur received it and told no one.

### The Twist — Arthur Crane
- Edmund confronts Arthur
- Arthur doesn't run. He sits down and explains it calmly — like a business decision
- Clara's letter would have destroyed the paper's relationship with Hargrove, who funds half their printing contracts
- Arthur knew the Ripper case details because he'd been editing the stories for months
- He used that knowledge to make Clara's death disappear into the noise
- "I tried to reason with her. She wouldn't stop."
- **Final morality choice — the heaviest in the game**

---

## Clue Delivery System

Clues come to Edmund in layered ways — not just "go to location, find clue":

| Source | How it works |
|---|---|
| **Edmund's eye** | As a typesetter he notices inconsistencies in the paper's Ripper coverage — things only someone who sets type would catch |
| **Rosie** | Children hear things adults ignore. She overheard something the night Clara died. |
| **Thomas** | Finds Clara's letter in Arthur's desk in Act 4 |
| **The tenement network** | People Clara helped pass things to Edmund quietly once they trust him |
| **Arthur himself** | Every tip he gives is real but misdirecting — visible on replay |

---

## Demo Scope (~20 minutes)
1. Opening scene — Edmund searches for Clara in a foggy alley, realisation she is gone
2. Police arrive, dismiss it as Ripper copycat, Edmund pushed aside
3. Edmund goes home — tells Thomas, Rosie doesn't understand
4. Neighbours arrive to help — offers of food, lodging, whispered condolences
5. Edmund returns to the alley alone at night — finds Mickey Daws
6. First morality choice
7. Edmund returns home — finds Clara's hidden note
8. Title card: *The Pale Lantern*

---

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
│   └── godotsteam/
├── scenes/
│   ├── main_menu.tscn
│   ├── game.tscn
│   ├── rooms/
│   │   ├── alley.tscn
│   │   ├── hale_home.tscn
│   │   ├── print_shop.tscn
│   │   ├── whitmore_street.tscn
│   │   └── hargrove_estate.tscn
│   ├── ui/
│   │   ├── dialogue.tscn
│   │   ├── inventory.tscn
│   │   ├── journal.tscn
│   │   └── lantern_meter.tscn
│   └── player/
│       └── player.tscn
├── scripts/
│   ├── autoloads/
│   │   ├── GameState.gd
│   │   ├── DialogueManager.gd
│   │   ├── LanternSystem.gd
│   │   └── SteamManager.gd
│   ├── objects/
│   │   ├── Interactable.gd
│   │   ├── NPC.gd
│   │   └── ClueItem.gd
│   └── ui/
│       ├── DialogueBox.gd
│       ├── Inventory.gd
│       ├── Journal.gd
│       └── LanternMeter.gd
├── assets/
│   ├── sprites/
│   ├── backgrounds/
│   ├── audio/
│   └── fonts/
└── data/
    ├── dialogue/
    │   ├── alley_opening.json
    │   ├── mickey_daws.json
    │   └── neighbours.json
    └── clues/
        └── claras_note.json
```

---

## Build Order

### Phase 1 — Scaffold
1. `project.godot` + full folder structure
2. Autoloads: GameState, DialogueManager, LanternSystem, SteamManager (stub)
3. Export presets: Windows + Linux

### Phase 2 — Player & Rooms
4. Player scene: point-and-click movement via NavigationAgent2D
5. Room base + room transition system (fade)
6. Alley scene (demo room 1)
7. Hale home scene (demo room 2)

### Phase 3 — Dialogue & Interactables
8. Interactable base class
9. Dialogue system (JSON-driven, speaker portrait, click to advance)
10. NPC class
11. Mickey Daws NPC with morality choice branching

### Phase 4 — Lantern System & Choices
12. LanternSystem autoload (tracks light/dark score)
13. Choice nodes in dialogue (multiple options, each affecting lantern)
14. LanternMeter UI (subtle visual indicator)

### Phase 5 — Inventory & Journal
15. Clue pickup + inventory panel
16. Journal (auto-updates with discoveries)
17. Clara's note clue

### Phase 6 — Demo Polish
18. Opening cinematic sequence (Edmund searching the alley)
19. Neighbour scene at the Hale home
20. Main menu
21. Save system
22. SteamManager with one achievement: "The Lantern is Lit" (complete the demo)
