extends CharacterBody3D


@export var camera:Camera3D
@export var raycast:RayCast3D


const MAX_SPEED = 1.7
const ACCELERATION = 7
const FRICTION = 10

const LOOK_SENSETIVITY = 0.005


func  _physics_process(delta):
	player_movement(delta)
	

func  player_movement(delta):
	var input_direction = Input.get_vector("left", "right", "forward", "back").normalized()
	
	if input_direction == Vector2.ZERO:
		# Slows
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector3.ZERO
	else:
		# Speeds
		velocity += ((input_direction.x * global_transform.basis.x) + (input_direction.y * global_transform.basis.z)) * (ACCELERATION * delta)
		velocity = velocity.limit_length(MAX_SPEED)
		
	move_and_slide()


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(- event.relative.x * LOOK_SENSETIVITY)
		camera.rotate_x(- event.relative.y * LOOK_SENSETIVITY)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		pass
		
	if Input.is_action_just_pressed("interact"):
		var collider = raycast.get_collider()
		if collider != null:
			collider.interact()
		

