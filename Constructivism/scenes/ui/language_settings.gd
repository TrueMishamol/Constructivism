extends Node
class_name LanguageSettings


static var languages = [
	"en",
	"ru",
]


static func get_current_locale_id() -> int:
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
	
	return current_locale_id
	

static func set_language_by_id(language_id: int):
	var language_save_file  = FileAccess.open("user://language_settings.data",FileAccess.WRITE)
	
	var locale: String = languages[language_id]
	TranslationServer.set_locale(locale)
	
	language_save_file.store_string(locale)
	

static func is_locale_saved() -> bool:
	var language_save_file = FileAccess.open("user://language_settings.data",FileAccess.READ)
	if language_save_file == null:
		return false
	else:
		return true
