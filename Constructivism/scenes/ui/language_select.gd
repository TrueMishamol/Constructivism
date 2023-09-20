extends OptionButton


@onready var _menu: CanvasLayer = get_tree().current_scene.get_node("Menu")


func _ready() -> void:
	_menu.on_language_choosen.connect(_menu_on_language_choosen)
	item_selected.connect(_on_item_selected)
	
	select(LanguageSettings.get_current_locale_id())
	

func _on_item_selected(index: int):
	LanguageSettings.set_language_by_id(index)
	

func _menu_on_language_choosen():
	select(LanguageSettings.get_current_locale_id())
	
