extends Node3D


@export var open_animation: String
@export var close_animation: String

var _animating: bool = false
var _opened: bool = false

@onready var _animation: AnimationPlayer = $AnimationPlayer


func _ready():
	_animation.animation_finished.connect(_on_animation_finished)
	
	if open_animation == "":
		var animation_list = _animation.get_animation_list()
		open_animation = animation_list[0]
	

func switch_state():
	if _animating:
		return
	
	_animating = true
	
	if _opened:
		_play_close_animation()
	else:
		_play_open_animation()
	

func _play_open_animation():
	_opened = true
	_animation.play(open_animation)
	

func _play_close_animation():
	_opened = false
	
	if close_animation != "":
		_animation.play(close_animation)
	else:
		_animation.play_backwards(open_animation)
	

func _on_animation_finished(_anim_name):
	_animating = false
	
