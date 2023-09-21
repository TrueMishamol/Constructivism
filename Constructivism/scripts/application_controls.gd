extends Node


@onready var menu: CanvasLayer = Singleton.menu


func _ready():
	process_mode = PROCESS_MODE_ALWAYS


func _input(event):
	if event.is_action_pressed("menu") and menu == null: 
		_toggle_pause()
		print("Add a menu to the scene, please")
	
	if event.is_action_pressed("fullscreen"):
		_toggle_fullscreen()
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()


func pause():
	get_tree().set_deferred("paused", true)
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)


func unpause():
	get_tree().set_deferred("paused", false)
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)


func _toggle_pause():
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_CAPTURED:
		pause()
	else:
		unpause()


func _toggle_fullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
