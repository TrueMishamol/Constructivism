extends OptionButton


var languages = [
	"en",
	"ru",
]


func _ready() -> void:
	item_selected.connect(_on_item_selected)
	
	var language_save_file = FileAccess.open("user://language_settings.data",FileAccess.READ)
	var current_locale: String = TranslationServer.get_locale()
	if current_locale == "en_US":
		# No localization selected 
		# Read localization from file
		if language_save_file == null:
			# No localization saved
			current_locale = "en"
			TranslationServer.set_locale(current_locale)
		else:
			# Localization load successfully from file
			current_locale = language_save_file.get_as_text()
			TranslationServer.set_locale(current_locale)
		
	var current_locale_id = languages.find(current_locale)
	select(current_locale_id)


func _on_item_selected(index: int):
	var locale: String = languages[index]
	TranslationServer.set_locale(locale)
	
	var language_save_file = FileAccess.open("user://language_settings.data",FileAccess.WRITE)
	language_save_file.store_string(locale)
