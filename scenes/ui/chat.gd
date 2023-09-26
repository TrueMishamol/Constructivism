extends CanvasLayer


@export var chat: Control
@export var label: Label
@export var display_duration: float = 5

var _displaying: bool = false 

var _queue: Array[String] = []

@onready var _animation = $AnimationPlayer


func _enter_tree():
	Singleton.chat = self


func _ready():
	_animation.animation_finished.connect(_on_animation_finished)
	

func display_message(message: String):
	# Add to queue:
	_queue.push_back(message)
	
	_check_for_queue()


func _check_for_queue():
	if _displaying:
		return
		
	if len(_queue) > 0:
		_fade_in()
	else:
		chat.hide()


func _fade_in():
	_displaying = true
	label.text = _queue.pop_front()
	_animation.play("fade_in")
	chat.show()


func _fade_out():
	_animation.play("fade_out")


func _on_animation_finished(anim_name):
	if anim_name == "fade_in":
		await get_tree().create_timer(display_duration).timeout
		_fade_out()
	
	if anim_name == "fade_out":
		_displaying = false
		_check_for_queue()
