extends CharacterBody2D

@export var health:int = 1000
@onready var animated_sprite = $AnimatedSprite2D
@export var gravity: float = 1200.0

@onready var text_healt = $TextEdit
var max_health: int
var stun_frame: int = 0

func _ready() -> void:
	max_health = health
	animated_sprite.play("idle")

func _physics_process(delta):
	if stun_frame > 0:
		stun_frame -= 1
	if not is_on_floor():
		velocity.y += gravity * delta
	else: if velocity.y > 0:
		velocity.y = 0
	text_healt.text = str(health) + " / " +  str(max_health)

func take_hit(data: FrameData) -> void:
	stun_frame = data.hitstun
	print("take ", data.damage, " damage")
	health -= data.damage
	animated_sprite.play("get_hit")


func _on_animated_sprite_2d_animation_finished() -> void:
	if velocity.y == 0:
		animated_sprite.play("idle")
