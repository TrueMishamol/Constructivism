extends PhysicsBody3D


@export var interactable_3d_model: Node


func interact():
	interactable_3d_model.switch_state()
