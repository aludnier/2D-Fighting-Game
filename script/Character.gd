extends RigidBody2D

@export var health:int = 100
@export var speed : float = 30
@onready var animated_sprite = $AnimatedSprite2D

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

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left movement", "right movement")
	self.position.x += direction * speed * delta
	pass


func take_hit(data: FrameData) -> void:
	print("take ", data.damage, " damage")
	health -= data.damage

func start_attack(pattern : attack) -> void:
	print("launch attack : ", pattern)
	currentAttack = attack_pattern[pattern]
	animated_sprite.play(attack_pattern[pattern].animation)
	attacking = true

func _unhandled_input(event: InputEvent) -> void:
	if attacking != true:
		print("check attack : ", event)
		if event.is_action_pressed("Light Attack"):
			start_attack(attack.LPUNCH)

func _on_animated_sprite_2d_animation_finished() -> void:
	print("end attack")
	attacking = false
	currentAttack = null
	animated_sprite.play("idle")


func _on_hitboxes_hit(oponent: Node2D) -> void:
	if target != null:
		return
	target = oponent
	oponent.take_hit(currentAttack.frames[animated_sprite.frame])
