extends Actor

export var stomp_impulse := 1500.0

func _physics_process(delta):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	if direction.x != 0:
		$player.rotation += direction.x * 10.2 * delta
	
	if Input.is_action_pressed("reboot"): # сделай в настройках проекта reboot на букву r
		set_position(Vector2(-150,500))
		
	for i in get_slide_count():
		var collision := get_slide_collision(i)
		var collider := collision.collider
		if collider is Enemy and is_on_floor() and collision.normal.dot(Vector2.UP) > 0.5:
			_velocity.y = -stomp_impulse
			(collider as Enemy).kill()
		
		
		# test

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_pressed("jump") and is_on_floor() else 1.0
	)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out


func reboot():
	
	#_velocity.y = 0
	#_velocity.x = 0
	print("reboot")
