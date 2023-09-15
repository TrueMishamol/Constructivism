extends CanvasLayer


@onready var application_controls = $"../ApplicationControls"
@onready var animation = $AnimationPlayer

@onready var quit_button = %Quit
@onready var github_button = %GitHub
@onready var album_button = %Album


var animating: bool = false


func  _ready():
	animation.animation_finished.connect(_on_animation_finished)
	
	quit_button.pressed.connect(func(): get_tree().quit())
	github_button.pressed.connect(func(): OS.shell_open("https://github.com/TrueMishamol/Constructivism"))
	album_button.pressed.connect(func(): OS.shell_open("https://vk.com/wall-176267168?q=%23%D0%94%D0%B8%D0%BF%D0%BB%D0%BE%D0%BC"))

func _input(event):
	toggle(event)
	

func toggle(event):
	if animating:
		return
	
	if event.is_action_pressed("menu"):
		# Esc button:
		if visible:
			turn_off()
		else:
			turn_on()
	else:
		if event is InputEventKey:
			if event.pressed:
				turn_off()


func turn_on():
	animating = true
	show()
	animation.play("fade_in")


func turn_off():
	animating = true
	application_controls.unpause()
	animation.play("fade_out")


func _on_animation_finished(anim_name):
	animating = false
	
	if anim_name == "fade_out":
		hide()
		
	if anim_name == "fade_in":
		application_controls.pause()
