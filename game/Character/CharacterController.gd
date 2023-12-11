extends KinematicBody2D

const SPEED: int = 250

export var user_id: String

onready var target: Vector2 = position

var velocity: Vector2


func _enter_tree():
	var _mc = PlayerEvent.connect("movement", self, "_handle_move_event")


func _exit_tree():
	PlayerEvent.disconnect("movement", self, "_handle_move_event")


func _physics_process(_delta):
	if position.distance_to(target) > 5:
		velocity = position.direction_to(target) * SPEED
		velocity = move_and_slide(velocity)


func _handle_move_event(msg, presence):
	if msg == null:
		return

	if presence.user_id != user_id:
		return

	var args = JSON.parse(msg).result
	_move_event(args)


func _move_event(args):
	target = Vector2(args.x, args.y)


