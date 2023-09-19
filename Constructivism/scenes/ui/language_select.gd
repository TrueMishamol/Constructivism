extends OptionButton


var languages = [
	"en",
	"ru",
]


func _ready() -> void:
	item_selected.connect(_on_item_selected)
	
	var current_locale = TranslationServer.get_locale()
	if current_locale == "en_US":
		TranslationServer.set_locale("en")
		current_locale = "en"
		
	var current_locale_id = languages.find(current_locale)
	select(current_locale_id)


func _on_item_selected(index: int):
	var locale: String = languages[index]
	TranslationServer.set_locale(locale)
