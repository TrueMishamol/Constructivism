extends CanvasLayer


signal on_language_choosen

@export var language_button: OptionButton
@export var ok_language_button: BaseButton

var animating: bool = false

@onready var application_controls = $"../ApplicationControls"
@onready var animation = $AnimationPlayer

@onready var language = $Menu/Language
@onready var welcome_menu = $Menu/WelcomeMenu
@onready var pause_menu = $Menu/PauseMenu
@onready var album = $Menu/Album
@onready var sources = $Menu/Sources


func _ready():
	animation.animation_finished.connect(_on_animation_finished)
	ok_language_button.pressed.connect(_on_ok_language_button_pressed)
	
	_hide_all_menus()
	
	if !LanguageSettings.is_locale_saved():
		_language_turn_on()
	else:
		_welcome_menu_turn_on()
	

func _input(event):
	_toggle(event)
	

func _on_ok_language_button_pressed():
	LanguageSettings.set_language_by_id(language_button.selected) 
	_welcome_menu_turn_on()
	on_language_choosen.emit()
	

func _hide_all_menus():
	language.hide()
	welcome_menu.hide()
	pause_menu.hide()
	album.hide()
	sources.hide()
	

func _welcome_menu_turn_on():
	_hide_all_menus()
	welcome_menu.show()
	
	application_controls.unpause()
	

func _language_turn_on():
	_hide_all_menus()
	language.show()
	
	application_controls.pause()
	

func _toggle(event):
	if animating:
		return
		
	if welcome_menu.visible and event is InputEventKey and event.pressed:
		# Any button pressed:
		_turn_off()
		return
	
	if event.is_action_pressed("menu"):
		# Esc button:
		if !visible:
			_turn_on()
			return
			
		if visible:
			if pause_menu.visible or language.visible:
				_turn_off()
			else:
				_hide_all_menus()
				pause_menu.show()
	

func _turn_on():
	animating = true
	show()
	animation.play("fade_in")
	application_controls.pause()
	

func _turn_off():
	animating = true
	application_controls.unpause()
	animation.play("fade_out")
	

func _on_animation_finished(anim_name):
	animating = false
	
	if anim_name == "fade_out":
		hide()
		_hide_all_menus()
		pause_menu.show()
	
