extends CharacterBody2D
class_name Player

@export var speed: float = 150.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var _moving: bool = false
var _queued_interaction: Interactable = null

func _ready() -> void:
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	nav_agent.navigation_finished.connect(_on_navigation_finished)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _unhandled_input(event: InputEvent) -> void:
	if DialogueManager.is_active():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		move_to(get_global_mouse_position())

func move_to(target: Vector2) -> void:
	nav_agent.target_position = target
	_moving = true
	anim.play("walk")

func move_to_then_interact(target: Vector2, interactable: Interactable) -> void:
	_queued_interaction = interactable
	move_to(target)

func _physics_process(_delta: float) -> void:
	if not _moving:
		velocity = Vector2.ZERO
		return
	if nav_agent.is_navigation_finished():
		_moving = false
		velocity = Vector2.ZERO
		anim.play("idle")
		return
	var next_pos := nav_agent.get_next_path_position()
	var direction := (next_pos - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	if direction.x < 0:
		anim.flip_h = true
	elif direction.x > 0:
		anim.flip_h = false

func _on_navigation_finished() -> void:
	_moving = false
	anim.play("idle")
	if _queued_interaction and _queued_interaction.can_interact():
		_queued_interaction._on_interact()
	_queued_interaction = null

func _on_dialogue_started(_id: String) -> void:
	_moving = false
	nav_agent.target_position = global_position
	anim.play("idle")

func _on_dialogue_ended(_id: String) -> void:
	pass
