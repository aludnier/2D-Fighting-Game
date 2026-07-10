extends State

var is_playing = false

func enter():
	print("enter land")
	player.animated_sprite.play("land")
	is_playing = true

func physics_update(delta: float):
	if !is_playing:
		machine.change_state(machine.Idle)

func animation_done():
	is_playing = false
