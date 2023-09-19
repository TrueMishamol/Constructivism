extends CanvasLayer


@onready var application_controls = $"../ApplicationControls"
@onready var animation = $AnimationPlayer

@onready var welcome_menu = $Menu/WelcomeMenu
@onready var pause_menu = $Menu/PauseMenu
@onready var album = $Menu/Album
@onready var sources = $Menu/Sources


var animating: bool = false


func  _ready():
	animation.animation_finished.connect(_on_animation_finished)
	
	welcome_menu.show()
	pause_menu.hide()
	album.hide()
	sources.hide()
	

func _input(event):
	toggle(event)
	

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
	application_controls.pause()


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
