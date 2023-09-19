extends CanvasLayer


@export var language_button: OptionButton
@export var ok_language_button: BaseButton


signal on_language_choosen


var animating: bool = false


@onready var application_controls = $"../ApplicationControls"
@onready var animation = $AnimationPlayer

@onready var language = $Menu/Language
@onready var welcome_menu = $Menu/WelcomeMenu
@onready var pause_menu = $Menu/PauseMenu
@onready var album = $Menu/Album
@onready var sources = $Menu/Sources


func  _ready():
	animation.animation_finished.connect(_on_animation_finished)
	ok_language_button.pressed.connect(_on_ok_language_button_pressed)
	
	var language_save_file = FileAccess.open("user://language_settings.data",FileAccess.READ)
	if language_save_file == null:
		language_turn_on()
	else:
		welcome_menu_turn_on()

	pause_menu.hide()
	album.hide()
	sources.hide()
	

func _input(event):
	toggle(event)
	

func language_turn_on():
	language.show()
	welcome_menu.hide()
	
	ApplicationControls.pause(self)


func _on_ok_language_button_pressed():
	LanguageSettings.set_language_by_id(language_button.selected) 
	welcome_menu_turn_on()
	on_language_choosen.emit()


func welcome_menu_turn_on():
	language.hide()
	welcome_menu.show()
	
	application_controls.unpause()
	

func toggle(event):
	if animating:
		return
		
	if welcome_menu.visible and event is InputEventKey and event.pressed:
		# Any button pressed:
		turn_off()
		return
	
	if event.is_action_pressed("menu"):
		# Esc button:
		if visible:
			if pause_menu.visible:
				turn_off()
			elif language.visible:
				welcome_menu_turn_on()
			else:
				pause_menu.show()
				album.hide()
				sources.hide()

		else:
			turn_on()
			

func turn_on():
	animating = true
	show()
	animation.play("fade_in")
	ApplicationControls.pause(self)


func turn_off():
	animating = true
	application_controls.unpause()
	animation.play("fade_out")


func _on_animation_finished(anim_name):
	animating = false
	
	if welcome_menu.visible:
		welcome_menu.hide()
		pause_menu.show()
	
	if anim_name == "fade_out":
		hide()
