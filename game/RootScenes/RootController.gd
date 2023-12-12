extends Node2D

@export var player_scene: PackedScene

@onready var player_entry_node: Node2D = find_child("PlayerEntry")
@onready var environment_items = find_child("EnvironmentItems")

var player: Node2D


func _ready():
	_add_player_to_scene()


func _add_player_to_scene():
	if player == null:
		player = player_scene.instantiate()

	player.position = player_entry_node.position
	player.name = SessionManager.session.user_id
	player.user_id = SessionManager.session.user_id
	environment_items.call_deferred("add_child", player)


