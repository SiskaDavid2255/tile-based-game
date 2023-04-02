extends Node

var params = {"players": 0, 
"grid_size": Vector2(0, 0),
"grid_pattern": "default"}

var grid_structure

func new_game(players, grid_size, grid_pattern):
	params.players = players
	params.grid_size = grid_size
	params.grid_pattern = grid_pattern
	get_tree().change_scene("res://scenes/game_session.tscn")

