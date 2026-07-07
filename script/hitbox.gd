extends Area2D

signal hit(oponent : Node2D)

func _on_body_entered(body: Node2D) -> void:
	if "character" in body:
		hit.emit(body)
