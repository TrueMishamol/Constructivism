extends Node3D


@export var open_animation: String
@export var close_animation: String


@onready var animation: AnimationPlayer = $AnimationPlayer


var animating: bool = false
var opened: bool = false


func _ready():
	animation.animation_finished.connect(_on_animation_finished)
	
	if open_animation == "":
		var animation_list = animation.get_animation_list()
		open_animation = animation_list[0]
		
	print ("open_animation = ", open_animation)


func switch_state():
	if animating:
		return
	
	if opened:
		play_close_animation()
	else:
		play_open_animation()


func play_open_animation():
	animating = true
	opened = true
	
	animation.play(open_animation)


func play_close_animation():
	animating = true
	opened = false
	
	if close_animation != "":
		animation.play(close_animation)
	else:
		animation.play_backwards(open_animation)
	
	
func _on_animation_finished(anim_name):
	animating = false
	
	print ("animating = ", animating)
	print ("opened = ", opened)
