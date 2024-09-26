extends Node2D




func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/game_scene.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/credits_scene.tscn")


var master_bus = AudioServer.get_bus_index("Master")

func _on_audio_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
