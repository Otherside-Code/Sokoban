extends Control



func _on_Iniciar_pressed():
	get_tree().change_scene("res://Scenes/Nivel1.tscn");


func _on_Iniciar2_pressed():
	get_tree().quit();
