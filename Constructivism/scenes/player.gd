extends CharacterBody3D


const MAX_SPEED = 1.7
const ACCELERATION = 7
const FRICTION = 10

const LOOK_SENSETIVITY = 0.005
const HELD_OBJECT_SPEED = 10

const LAYER_INTERACTABLE = 4
const LAYER_MOVABLE = 8
const LAYER_IN_MOTION = 16

@export var _camera:Camera3D
@export var _raycast:RayCast3D
@export var _hold_position:Node3D

var _held_object: RigidBody3D
var _start_hold_rotation
var _start_held_object_rotation 

@onready var _crosshair = $Cross


func  _physics_process(delta):
	_player_movement(delta)
	_player_picking_up_objects(delta)
	

func _input(event):
	if event is InputEventMouseMotion:
		_camera_rotation(event)
		
	_raycasting()

func _camera_rotation(event):
	rotate_y(-event.relative.x * LOOK_SENSETIVITY)
	_camera.rotate_x(-event.relative.y * LOOK_SENSETIVITY)
	_camera.rotation.x = clamp(_camera.rotation.x, -PI/2, PI/2)
	

func _raycasting():
	var collider = _raycast.get_collider()
	
	if collider == null:
		_crosshair.hide()
	else:
		_crosshair.show()
	
	if Input.is_action_just_pressed("interact"):
		if _held_object:
			_held_object.freeze = false
			_held_object.collision_layer = LAYER_MOVABLE
			_held_object = null
			return
	
	if collider and Input.is_action_just_pressed("interact"):
		var collision_layer = collider.get_collision_layer()
		match collision_layer:
			LAYER_INTERACTABLE:
				collider.interact()
			LAYER_MOVABLE:
				_held_object = collider
				print(_held_object)
				_held_object.collision_layer = LAYER_IN_MOTION
				
				_start_hold_rotation = _hold_position.global_rotation
				_start_held_object_rotation = _held_object.global_rotation

func _player_movement(delta):
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
	

func _player_picking_up_objects(delta):
	if _held_object == null:
		return
	
	var object_position = _held_object.global_transform.origin
	var target_position = _hold_position.global_transform.origin
	
	var direction = (target_position - object_position)
	
	_held_object.linear_velocity = direction * HELD_OBJECT_SPEED
	
	# Rotates Held object with Player by Y axis:
	_held_object.global_rotation = _start_held_object_rotation + Vector3(0, _hold_position.global_rotation.y, 0) - Vector3(0, _start_hold_rotation.y, 0)
