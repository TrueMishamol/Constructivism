extends Node


@onready var _hall = $"../House/Areas/Hall"
@onready var _livingroom = $"../House/Areas/Livingroom"
@onready var _bathroom = $"../House/Areas/Bathroom"
@onready var _guestroom = $"../House/Areas/Guestroom"
@onready var _kitchen = $"../House/Areas/Kitchen"


func _ready():
	_hall.connect("body_entered", _on_hall_body_entered)
	_livingroom.connect("body_entered", _on_livingroom_body_entered)
	_bathroom.connect("body_entered", _on_bathroom_body_entered)
	_guestroom.connect("body_entered", _on_guestroom_body_entered)
	_kitchen.connect("body_entered", _on_kitchen_body_entered)


func _on_hall_body_entered(body):
	Singleton.chat.display_message("HINT_CROSSHAIR_INTERACT")
	_hall.disconnect("body_entered", _on_hall_body_entered)


func _on_livingroom_body_entered(body):
	Singleton.chat.display_message("HINT_LIVINGROOM_PARTITION")
	Singleton.chat.display_message("HINT_LIVINGROOM_TABLE")
	Singleton.chat.display_message("HINT_CURTAINS")
	_livingroom.disconnect("body_entered", _on_livingroom_body_entered)
	

func _on_bathroom_body_entered(body):
	Singleton.chat.display_message("HINT_BATHROOM_GLASS_DOORS")
	_bathroom.disconnect("body_entered", _on_bathroom_body_entered)


func _on_guestroom_body_entered(body):
	Singleton.chat.display_message("HINT_GUESTROOM_TABLE")
	_guestroom.disconnect("body_entered", _on_guestroom_body_entered)


func _on_kitchen_body_entered(body):
	Singleton.chat.display_message("HINT_MOVABLE_FURNITURE")
	Singleton.chat.display_message("HINT_ROTATE_FURNITURE")
	_kitchen.disconnect("body_entered", _on_kitchen_body_entered)
