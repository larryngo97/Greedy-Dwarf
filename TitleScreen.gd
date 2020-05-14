extends Control


func _ready():
	pass

func _on_QuitGameButton_pressed():
	get_tree().quit()
	
	
func _on_NewGameButton_pressed():
		get_tree().change_scene("res://Scene/Game.tscn")


