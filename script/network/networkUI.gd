extends Control


@export var next_scene : PackedScene

func _on_server_pressed() -> void:
	NetworkHandler.start_server()
	get_tree().change_scene_to_packed(next_scene)


func _on_client_pressed() -> void:
	NetworkHandler.start_client()
	get_tree().change_scene_to_packed(next_scene)
