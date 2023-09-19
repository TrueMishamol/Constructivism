extends Sprite2D


func _process(_delta):
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_CAPTURED:
		return
		
	if is_pixel_opaque(get_local_mouse_position()):
		modulate = Color(1, 0, 0.231)
	else:
		modulate = Color(1, 1, 1)
	
