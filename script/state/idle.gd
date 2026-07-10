extends State

func  enter():
	print("enter Idle")
	#player.animated_sprite.play("Idle")

func physics_update(delta: float):
	if Input.get_axis("left movement", "right movement") != 0:
		machine.change_state(machine.Walk)
		return


func change_to_attack(attack: Character.attack) -> void:
	machine.next_attack = attack
	machine.change_state(machine.Attack)

func handle_input(event):
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		machine.change_state(machine.Jump)
		return

	if event.is_action_pressed("Light Attack"):
		change_to_attack(Character.attack.LPUNCH)
		return

	if event.is_action_pressed("Heavy Attack"):
		change_to_attack(Character.attack.HPUNCH)
		return

	if event.is_action_pressed("Light Special"):
		change_to_attack(Character.attack.LSPE)
		return

	if event.is_action_pressed("Heavy Special"):
		change_to_attack(Character.attack.HSPE)
		return
