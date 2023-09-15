extends StaticBody3D


@export var animation: AnimationPlayer


var opened: bool = false
var animating: bool = false


func interact():
	if animating:
		return
	
	if opened:
		close()
	else:
		open()


func open():
	opened = true
	animating = true
	animation.play("door_open")
	

func close():
	opened = false
	animating = true
	animation.play("door_close")


func _on_animation_player_animation_finished(anim_name):	
	animating = false
