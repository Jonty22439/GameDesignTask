extends Node2D




func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits_scene.tscn")
