extends "res://actors/player-states/RobotIdle.gd"

func _state_enter(info: Dictionary) -> void:
	host.play_animation("Robot Move")
	if info.has('input_vector'):
		do_move(info['input_vector'])


func _state_physics_process(delta: float) -> void:
	_check_pickup_or_throw_or_use()
	
	var input_vector = _get_player_input_vector()
	if input_vector == Vector2.ZERO:
		get_parent().change_state("RobotIdle")
		return
	
	do_move(input_vector)

func do_flip_sprite(input_vector: Vector2) -> void:
	if input_vector.x < 0:
		host.flip_h = true
	elif input_vector.x > 0:
		host.flip_h = false

func do_move(input_vector: Vector2) -> void:
	do_flip_sprite(input_vector)
	
	# Accelerate to top speed.
	var delta = get_physics_process_delta_time()
	if input_vector.x > 0:
		host.vector.x = min(input_vector.x * host.speed, host.vector.x + (host.acceleration * delta))
	elif input_vector.x < 0:
		host.vector.x = max(input_vector.x * host.speed, host.vector.x - (host.acceleration * delta))
	else:
		_decelerate_to_zero(delta)
