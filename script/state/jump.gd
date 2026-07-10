extends State

func enter():
	player.animated_sprite.play("jump")
	player.velocity.y = player.jump_force
	player.move_and_slide()

func physics_update(delta: float):
	if player.velocity.y >= 0:
		player.animated_sprite.play("fall")
	if player.is_on_floor():
		player.velocity.y = 0
		machine.change_state(machine.Land)

func exit():
	player.velocity = Vector2.ZERO
