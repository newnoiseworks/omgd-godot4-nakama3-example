extends CharacterBody2D

const SPEED: int = 250

@export var user_id: String

@onready var target: Vector2 = position


func _enter_tree():
	PlayerEvent.movement_signal.connect(_handle_move_event)


func _exit_tree():
	PlayerEvent.movement_signal.disconnect(_handle_move_event)


func _physics_process(_delta):
	if position.distance_to(target) > 5:
		print_debug(position, target)
		velocity = position.direction_to(target) * SPEED
		move_and_slide()


func _handle_move_event(msg, presence):
	print_debug(msg, presence)
	if msg == null:
		return

	if presence.user_id != user_id:
		return

	var args = JSON.parse_string(msg)
	_move_event(args)


func _move_event(args):
	target = Vector2(args.x, args.y)


