extends "res://Character/CharacterController.gd"

# icon from https://www.reddit.com/r/godot/comments/icagss/i_made_a_claylike_3d_desktop_icon_for_godot_ico/

const INPUT_MOVE: int = 20


func _physics_process(_delta: float):
	target = position

	if Input.is_action_pressed("move_right"):
		target.x += INPUT_MOVE
	if Input.is_action_pressed("move_left"):
		target.x -= INPUT_MOVE
	if Input.is_action_pressed("move_down"):
		target.y += INPUT_MOVE
	if Input.is_action_pressed("move_up"):
		target.y -= INPUT_MOVE

	if (target.distance_to(position) > INPUT_MOVE - 5):
		PlayerEvent.movement({"x": target.x, "y": target.y})


