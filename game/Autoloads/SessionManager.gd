extends Node

var session: NakamaSession

var api_account: NakamaAPI.ApiAccount

signal post_auth

@onready var client = Nakama.create_client(
	GameConfig.nakama_key,
	GameConfig.nakama_host,
	GameConfig.nakama_port,
	"https" if GameConfig.nakama_secure else "http"
)


func rpc_async(uri: String, payload: String = "") -> NakamaAPI.ApiRpc:
	return await client.rpc_async(session, uri, payload)


func login(email: String, password: String):
	if client == null:
		client = Nakama.create_client(
			GameConfig.nakama_key,
			GameConfig.nakama_host,
			GameConfig.nakama_port,
			"https" if GameConfig.nakama_secure else "http"
		)

	session = await client.authenticate_email_async(email, password)
	emit_signal("post_auth")

	return session


func signup(email: String, username: String, password: String):
	if client == null:
		client = Nakama.create_client(
			GameConfig.nakama_key,
			GameConfig.nakama_host,
			GameConfig.nakama_port,
			"https" if GameConfig.nakama_secure else "http"
		)

	session = await client.authenticate_email_async(email, password, username, true)
	emit_signal("post_auth")

	return session
