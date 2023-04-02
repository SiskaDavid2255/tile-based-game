extends Control


onready var custom_game_menu = get_node("CustomGameMenu")
onready var main_menu_container = get_node("MainMenuContainer")

func _on_Button_pressed():
	GameManager.new_game(3, Vector2(16, 16), [["w", "w"]])


func _on_CustomGameBtn_pressed():
	main_menu_container.visible = false
	print(custom_game_menu)
	custom_game_menu.visible = true
	


func _on_QuitBtn_pressed():
	get_tree().quit()
