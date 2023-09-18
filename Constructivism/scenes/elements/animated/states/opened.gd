extends State
class_name Opened


@export var interactable_3d_model: Node3D


func interact():
	transitioned.emit(self, "animating")
