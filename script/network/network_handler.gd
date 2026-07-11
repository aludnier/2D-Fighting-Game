extends Node

const IP_ADRESS = "localhost"
const PORT: int = 42068

var peer: ENetMultiplayerPeer

func _ready():
	multiplayer.peer_connected.connect(_peer_connected)
	multiplayer.peer_disconnected.connect(_peer_disconnected)

func _peer_connected(id):
	print("Joueur connecté :", id)

func _peer_disconnected(id):
	print("Joueur déconnecté :", id)

func start_server() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, 1)
	if error != OK:
		print("Erreur création serveur :", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Serveur lancé sur le port ", PORT)

func start_client() -> void:
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(IP_ADRESS, PORT)
	if error != OK:
		print("Erreur connexion serveur :", error)
		return
	multiplayer.multiplayer_peer = peer
	print("Connexion au serveur...")
