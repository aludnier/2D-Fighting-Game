extends Node
class_name StateMachine


@export var Idle: State
@export var Walk: State
@export var Jump: State
@export var Land: State
@export var Attack: State
@export var Stun: State

var current_state: State
var next_attack: Character.attack
@export var player: Character

func _ready() -> void:
	for s in get_children():
		s.setup(player, self)


func change_state(new_state):
	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()


func update(delta):
	if current_state:
		current_state.update(delta)


func physic_update(delta):
	if current_state:
		current_state.physics_update(delta)


func handle_input(event: InputEvent):
	if current_state:
		current_state.handle_input(event)
