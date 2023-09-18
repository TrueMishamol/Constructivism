extends State
class_name Animating


#@export var animation: AnimationPlayer
@export var interactable_3d_model: Node3D


func enter():
	interactable_3d_model.play_open_animation
#	animation.animation_finished.connect(func(): transitioned.emit(self, "opened"))


