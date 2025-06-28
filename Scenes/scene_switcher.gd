extends Node

func load_question_list(import_path: String,) ->QuestionList :
	if not ResourceLoader.exists(import_path):
		print("invalid path")
		return null

	var list: QuestionList = ResourceLoader.load(import_path)
	if not list:
		OS.alert("failed to load list")
		print("failed to load list")
		return null
	#if list.uid == Utils.player_uid:
		#print("You can't open your own list!")
		#return null
	var list_instance = list.duplicate()
	return list_instance
	
func _on_main_screen_file_found(path: String) -> void:
	var list = load_question_list(path)
	if path != null:
		Gloabl.current_list = list
		get_tree().change_scene_to_file("res://Scenes/Main.tscn")
