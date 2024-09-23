extends Node2D


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_game.tscn")
