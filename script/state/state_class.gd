extends Node
class_name State

var player: Character
var machine: StateMachine

func setup(p, m):
	player = p
	machine = m

func enter():
	pass

func exit():
	pass

func update(delta: float):
	pass

func physics_update(delta: float):
	pass

func handle_input(event: InputEvent):
	pass
