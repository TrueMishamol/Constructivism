extends CharacterBody3D


const MAX_SPEED = 1.7
const ACCELERATION = 7
const FRICTION = 10

const LOOK_SENSETIVITY = 0.005
const HELD_OBJECT_SPEED = 10
const HELD_ROTATION_POWER = 1

const LAYER_INTERACTABLE = 4
const LAYER_MOVABLE = 8
const LAYER_IN_MOTION = 16

@export var camera: Camera3D
@export var raycast: RayCast3D
@export var hold_position: Node3D
@export var hold_joint: Generic6DOFJoint3D
@export var hold_static_body: StaticBody3D

var _held_object: RigidBody3D
var _view_locked = false

@onready var _crosshair = $Cross


func _enter_tree():
	Singleton.player_camera = camera


func  _physics_process(delta):
	_player_movement(delta)
	_player_holding_object()


func _input(event):
	if event is InputEventMouseMotion and !_view_locked:
		_camera_rotation(event)
		
	_raycasting()
	
	if Input.is_action_pressed("rotate"):
		_view_locked = true
		_rotate_held_object(event)
	if Input.is_action_just_released("rotate"):
		_view_locked = false


func _camera_rotation(event):
	rotate_y(-event.relative.x * LOOK_SENSETIVITY)
	camera.rotate_x(-event.relative.y * LOOK_SENSETIVITY)
	camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)


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


func _raycasting():
	var collider = raycast.get_collider()
	
	if collider == null:
		_crosshair.hide()
	else:
		_crosshair.show()
	
	if Input.is_action_just_pressed("interact"):
		# Drop held object:
		if _held_object:
			_drop_held_object()
			return
			
		# Interact with object:
		if collider:
			var held_collision_layer = collider.get_collision_layer()
			match held_collision_layer:
				LAYER_INTERACTABLE:
					collider.interact()
				LAYER_MOVABLE:
					_pick_up_object(collider)


func _pick_up_object(collider):
	_held_object = collider
	_held_object.collision_layer = LAYER_IN_MOTION
	
	hold_joint.node_b = _held_object.get_path()


func _drop_held_object():
	_held_object.collision_layer = LAYER_MOVABLE
	hold_joint.node_b = ""
	_held_object = null


func _rotate_held_object(event):
	if _held_object:
		if event is InputEventMouseMotion:
			hold_static_body.rotate_x(deg_to_rad(event.relative.y * HELD_ROTATION_POWER))
			hold_static_body.rotate_y(deg_to_rad(event.relative.x * HELD_ROTATION_POWER))


func _player_holding_object():
	if _held_object == null:
		return
	
	var object_position = _held_object.global_transform.origin
	var target_position = hold_position.global_transform.origin
	var direction = (target_position - object_position)
	
	_held_object.linear_velocity = direction * HELD_OBJECT_SPEED
