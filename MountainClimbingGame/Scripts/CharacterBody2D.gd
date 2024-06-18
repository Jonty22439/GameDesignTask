extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -650.0
# Jumping variables for double jump
var max_jumps = 2
var jump_count = 0
# Dashing variables for dashing
const DASH_SPEED = 900.0
var dashing = false
var can_dash = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count = jump_count + 1
	
	if Input.is_action_just_pressed("Dash") and can_dash == true:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_again_timer.start()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("LeftWalk", "RightWalk")
	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_dash_timer_timeout():
	dashing = false


func _on_dash_again_timer_timeout():
	can_dash = true
