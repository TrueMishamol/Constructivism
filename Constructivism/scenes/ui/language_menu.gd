extends CanvasLayer


@export var play_button: BaseButton
@export_file var scene_path


func _ready():
	play_button.pressed.connect(func(): get_tree().change_scene_to_file(scene_path))
