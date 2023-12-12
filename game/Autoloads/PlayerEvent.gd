extends Node

enum {
  MOVEMENT = 0,
}

signal movement_signal(state, presence)

var signal_map = {
	MOVEMENT: movement_signal,
}


func handle_match_state_update(state: NakamaRTAPI.MatchData):
	if state.presence != null && state.presence.user_id == SessionManager.session.user_id:
		return

	match state.op_code:
		MOVEMENT:
			emit_signal("movement_signal", state.data, state.presence)


func emit(op_code: int, payload: String):
	var event: Signal = signal_map[op_code]
	event.emit(payload, {"user_id": SessionManager.session.user_id})

	if PlayerManager.game_match != null:
		PlayerManager.socket.send_match_state_async(
			PlayerManager.game_match.match_id, op_code, payload
		)


func movement(payload):
	emit(MOVEMENT, JSON.stringify(payload))
