extends State

var is_playing = false

func enter():
	player.velocity = Vector2.ZERO
	player.start_attack(machine.next_attack)
	is_playing = true	

func physics_update(delta: float):
	if !is_playing:
		machine.change_state(machine.Idle)

func animation_done():
	is_playing = false

func exit():
	player.reset_attack()
