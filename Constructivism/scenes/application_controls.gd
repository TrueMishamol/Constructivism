extends Node
class_name ApplicationControls


@export var menu: CanvasLayer


func _ready():
	if menu == null:
		menu = $"../Menu"
		return


func _input(event):
	if event.is_action_pressed("menu") and menu == null: 
		toggle_pause()
		print("Add a menu to the scene, please")

	
	if event.is_action_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		

static func pause(emitter):
	emitter.get_tree().set_deferred("paused", true)
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	
	
func unpause():
	get_tree().set_deferred("paused", false)
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)


func toggle_pause():
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_CAPTURED:
		get_tree().set_deferred("paused", true)
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	else:
		get_tree().set_deferred("paused", false)
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
