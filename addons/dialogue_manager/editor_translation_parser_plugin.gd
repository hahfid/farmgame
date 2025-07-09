extends EditorTranslationParserPlugin


const DialogueConstants = preload("./constants.gd")
const DialogueSettings = preload("./settings.gd")
const DialogueManagerParser = preload("./components/parser.gd")
const DialogueManagerParseResult = preload("./components/parse_result.gd")


func _parse_file(path: String) -> Array[PackedStringArray]:
	var msgids_context_plural: Array[PackedStringArray] = []
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: %s" % path)
		return msgids_context_plural

	var text: String = file.get_as_text()
	var data: DialogueManagerParseResult = DialogueManagerParser.parse_string(text, path)
	var known_keys: PackedStringArray = []

	# Tambahkan karakter jika diminta
	if DialogueSettings.get_setting("export_characters_in_translation", true):
		for character_name in data.character_names:
			if character_name in known_keys:
				continue
			known_keys.append(character_name)
			msgids_context_plural.append([character_name.replace('"', '\"'), "dialogue", ""])

	# Tambahkan dialog dan response
	for key in data.lines.keys():
		var line: Dictionary = data.lines[key]
		if not line.type in [DialogueConstants.TYPE_DIALOGUE, DialogueConstants.TYPE_RESPONSE]:
			continue
		if line.translation_key in known_keys:
			continue
		known_keys.append(line.translation_key)

		if line.translation_key == "" or line.translation_key == line.text:
			msgids_context_plural.append([line.text.replace('"', '\"'), "", ""])
		else:
			msgids_context_plural.append([line.text.replace('"', '\"'), line.translation_key.replace('"', '\"'), ""])

	return msgids_context_plural


func _get_recognized_extensions() -> PackedStringArray:
	return ["dialogue"]
