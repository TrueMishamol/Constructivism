extends Node3D


@export var open_animation: String
@export var close_animation: String

var animating: bool = false
var opened: bool = false

@onready var animation: AnimationPlayer = $AnimationPlayer


func _ready():
	animation.animation_finished.connect(_on_animation_finished)
	
	if open_animation == "":
		var animation_list = animation.get_animation_list()
		open_animation = animation_list[0]
	

func switch_state():
	if animating:
		return
	
	animating = true
	
	if opened:
		_play_close_animation()
	else:
		_play_open_animation()
	

func _play_open_animation():
	opened = true
	animation.play(open_animation)
	

func _play_close_animation():
	opened = false
	
	if close_animation != "":
		animation.play(close_animation)
	else:
		animation.play_backwards(open_animation)
	

func _on_animation_finished(anim_name):
	animating = false
	
