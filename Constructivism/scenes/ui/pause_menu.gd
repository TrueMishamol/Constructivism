extends Control


@export var quit_button: BaseButton
@export var sources_button: BaseButton
@export var album_button: BaseButton

@onready var _album = $"../Album"
@onready var _sources = $"../Sources"


func  _ready():
	quit_button.pressed.connect(func(): get_tree().quit())
	sources_button.pressed.connect(_open_sources)
	album_button.pressed.connect(_open_album)
	

func _open_sources():
	_sources.show()
	hide()
	

func _open_album():
	_album.show()
	hide()
	
