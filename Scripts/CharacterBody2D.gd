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
# Spawn variables
const SPAWN_Y = 400
const SPAWN_X = 585

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		jump_count = 0
	if dashing:
		velocity.y = 0
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count = jump_count + 1
		$jumpsfx.play()
	
	if Input.is_action_just_pressed("Dash") and can_dash == true:
		dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_again_timer.start()
		$dashsfx.play()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("LeftWalk", "RightWalk")
	if direction:
		if dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
			if is_on_floor():
				anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("idle")
	if not is_on_floor():
		if dashing:
			anim.play("dash")
		else:
			anim.play("jump")
			
	# Dash Particles
	if dashing:
		$DashEffects.emitting = true
	else:
		$DashEffects.emitting = false
	# Walking Particles
	if is_on_floor() and direction:
		$WalkingParticles.emitting = true
		if $walkingsfx.playing == false:
			$walkingsfx.play()
	else:
		$WalkingParticles.emitting = false
		
	# Respawning system, this is a temporary fix to respawning
	# I plan on making checkpoints at some point
	if position.y >= 1000:
		position.y = SPAWN_Y
		position.x = SPAWN_X
	move_and_slide()
func _on_dash_timer_timeout():
	dashing = false
func _on_dash_again_timer_timeout():
	can_dash = true
