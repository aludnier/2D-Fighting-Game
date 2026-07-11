extends MultiplayerSpawner

@export var player_scene: PackedScene

func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	
	if multiplayer.is_server():
		spawn_player(1)

func spawn_player(id: int) -> void:
	if !multiplayer.is_server():
		return
	
	var player: CharacterBody2D = player_scene.instantiate()
	player.position.x = 200
	player.name = str(id)
	
	get_node(spawn_path).call_deferred("add_child", player)
