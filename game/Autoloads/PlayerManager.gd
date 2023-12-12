extends Node

var socket: NakamaSocket
var game_match: NakamaRTAPI.Match


func connect_socket():
	if socket != null:
		return

	socket = Nakama.create_socket_from(SessionManager.client)
	await socket.connect_async(SessionManager.session)
	var _cr = socket.connect("received_match_state", Callable(self, "_on_match_state"))
	var _cc = socket.connect("closed", Callable(self, "_on_socket_disconnect"))


func find_or_create_match(label: String, starting_position: Vector2):
	var response = await SessionManager.rpc_async("find_or_create_player", "player_type")

	var match_id = response.payload.replace('"', "")

	var _match = await _join_match(match_id, label, starting_position)

	return _match


func leave_match():
	if game_match != null:
		await socket.leave_match_async(game_match.match_id)
		game_match = null


func _join_match(match_id: String, _label: String, _starting_position: Vector2) -> NakamaRTAPI.Match:
	game_match = await socket.join_match_async(match_id)

	if game_match.is_exception():
		print("An error occured attempting to join the match: %s" % game_match)
		return

	return game_match


func _on_match_state(state: NakamaRTAPI.MatchData):
	PlayerEvent.handle_match_state_update(state)


func _on_socket_disconnect():
	# TPLG.base_change_scene("res://RootScenes/Authentication/Authentication.tscn")
	pass
