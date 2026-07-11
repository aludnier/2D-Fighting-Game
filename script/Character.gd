extends CharacterBody2D
class_name Character

@export var health:int = 100
@export var speed : float = 300
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var gravity: float = 1200.0
@export var jump_force := -1000.0
@export var state_machine: StateMachine

enum attack {
	LPUNCH, HPUNCH, LLOW, HLOW, LHIGH, HHIGH,
	LSPE, HSPE, LLOWSPE, HLOWSPE, LHIGHSPE, HHIGHSPE
}

@export var Lpunch : AttackData
@export var Hpunch : AttackData
@export var Llow : AttackData
@export var Hlow : AttackData
@export var Lhigh : AttackData
@export var Hhigh : AttackData
@export var Lspe : AttackData
@export var Hspe : AttackData
@export var Llowspe : AttackData
@export var Hlowspe : AttackData
@export var Lhighspe : AttackData
@export var Hhighspe : AttackData

@onready var attack_pattern : Dictionary = {
	attack.LPUNCH : Lpunch,
	attack.HPUNCH : Hpunch,
	attack.LLOW : Llow,
	attack.HLOW : Hlow,
	attack.LHIGH : Lhigh,
	attack.HHIGH : Hhigh,
	attack.LSPE : Lspe,
	attack.HSPE : Hspe,
	attack.LLOWSPE : Llowspe,
	attack.HLOWSPE : Hlowspe,
	attack.LHIGHSPE : Lhighspe,
	attack.HHIGHSPE : Hhighspe,
}

var currentAttack : AttackData
var target : Node2D = null
var attacking: bool = false
var jumping: bool = false
var falling: bool = false

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready() -> void:
	state_machine.change_state(state_machine.Idle)

func _physics_process(delta):
	if !is_multiplayer_authority():
		return
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	state_machine.physic_update(delta)
	move_and_slide()

func take_hit(data: FrameData) -> void:
	print("take ", data.damage, " damage")
	health -= data.damage

func start_attack(pattern : attack) -> void:
	velocity.x = 0
	print("launch attack : ", pattern)
	currentAttack = attack_pattern[pattern]
	animated_sprite.play(attack_pattern[pattern].animation)
	target = null
	attacking = true
	attack_frame = 0

func _unhandled_input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
	state_machine.handle_input(event)

func reset_attack():
	for hb in hitboxes.get_children():
		hb.disabled = true
	attacking = false
	currentAttack = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if state_machine.current_state.has_method("animation_done"):
		state_machine.current_state.animation_done()


func _on_hitboxes_hit(oponent: Node2D) -> void:
	if target != null:
		return
	target = oponent
	oponent.take_hit(currentAttack.frames[attack_frame])

@onready var hitboxes = $hitboxes
@onready var shaped_hb: Array[CollisionShape2D] = [
	$hitboxes/hitbox1,
	$hitboxes/hitbox2,
	$hitboxes/hitbox3,
	$hitboxes/hitbox4
]

func set_hitbox(hb : CollisionShape2D, data : HitboxData) -> void:
	var shape := hb.shape.duplicate() as RectangleShape2D
	shape.size = data.size
	hb.shape = shape

	hb.position = data.offset
	hb.disabled = false


var attack_frame:int = 0
func _on_animated_sprite_2d_frame_changed() -> void:
	if currentAttack == null:
		return
	if animated_sprite.frame < currentAttack.startFrame and animated_sprite.frame > currentAttack.endFrame:
		return

	for hb in hitboxes.get_children():
		hb.disabled = true
	var hitbox_nb = 0
	print(animated_sprite.frame)
	if attack_frame >= currentAttack.frames.size() :
		attack_frame -= 1
		return
	for data in currentAttack.frames[attack_frame].hitbox:
		set_hitbox(shaped_hb[hitbox_nb], data)
		hitbox_nb += 1
	if attack_frame + 1 < currentAttack.frames.size():
		attack_frame += 1
