extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		velocity.x = direction * SPEED
		$PlayerSprite.flip_h = false
	elif direction < 0:
		velocity.x = direction * SPEED
		$PlayerSprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			$PlayerSprite.play("default")
		else:
			$PlayerSprite.play("move")
	else:
		$PlayerSprite.play("jump")	

	move_and_slide()
