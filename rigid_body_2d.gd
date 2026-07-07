extends RigidBody2D

@onready var animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("space"):
		animated_sprite.play("light-punch")


func _on_animated_sprite_2d_animation_finished() -> void:
	animated_sprite.play("idle")
	pass # Replace with function body.
