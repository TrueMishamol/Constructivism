extends CanvasLayer


signal on_language_choosen

@export var language_button: OptionButton
@export var ok_language_button: BaseButton

var _animating: bool = false

@onready var _application_controls = $"../ApplicationControls"
@onready var _animation = $AnimationPlayer

@onready var _language = $Menu/Language
@onready var _welcome_menu = $Menu/WelcomeMenu
@onready var _pause_menu = $Menu/PauseMenu
@onready var _album = $Menu/Album
@onready var _sources = $Menu/Sources


func _ready():
	_animation.animation_finished.connect(_on_animation_finished)
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
	_language.hide()
	_welcome_menu.hide()
	_pause_menu.hide()
	_album.hide()
	_sources.hide()
	

func _welcome_menu_turn_on():
	_hide_all_menus()
	_welcome_menu.show()
	
	_application_controls.unpause()
	

func _language_turn_on():
	_hide_all_menus()
	_language.show()
	
	_application_controls.pause()
	

func _toggle(event):
	if _animating:
		return
		
	if _welcome_menu.visible and event is InputEventKey and event.pressed:
		# Any button pressed:
		_turn_off()
		return
	
	if event.is_action_pressed("menu"):
		# Esc button:
		if !visible:
			_turn_on()
			return
			
		if visible:
			if _pause_menu.visible or _language.visible:
				_turn_off()
			else:
				_hide_all_menus()
				_pause_menu.show()
	

func _turn_on():
	_animating = true
	show()
	_animation.play("fade_in")
	_application_controls.pause()
	

func _turn_off():
	_animating = true
	_application_controls.unpause()
	_animation.play("fade_out")
	

func _on_animation_finished(anim_name):
	_animating = false
	
	if anim_name == "fade_out":
		hide()
		_hide_all_menus()
		_pause_menu.show()
	
