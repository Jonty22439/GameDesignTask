extends Area2D

var change_scene = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player Collision")
		change_scene = true
		
func _process(_delta):
	if change_scene:
		get_tree().change_scene_to_file("res://Scenes/win_scene.tscn")
