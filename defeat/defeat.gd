extends Control


func _on_reset_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/Juego.tscn")
	GameManager.reiniciar_y_jugar()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/Menu.tscn")
