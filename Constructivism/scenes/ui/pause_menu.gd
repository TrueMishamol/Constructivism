extends Control


@export var quit_button: BaseButton
@export var sources_button: BaseButton
@export var album_button: BaseButton


@onready var album = $"../Album"
@onready var sources = $"../Sources"


func  _ready():
	quit_button.pressed.connect(func(): get_tree().quit())
	sources_button.pressed.connect(open_sources)
	album_button.pressed.connect(open_album)


func open_sources():
	sources.show()
	hide()


func open_album():
	album.show()
	hide()
	
