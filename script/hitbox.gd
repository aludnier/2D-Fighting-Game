extends Area2D

signal hit(oponent : Node2D)
@onready var character = $".."

func _on_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("character") and body != character :
		hit.emit(body)
