class_name GridResource
extends Resource

export var tiles = [[]]

#func _init():
#	tiles = [["w", "w", "w", "w", "w", "w", "w"],
#				["g", "g", "g", "g", "g", "w", "w"],
#				["g", "g", "g", "g", "w", "w", "w"],
#				["w", "g", "w", "w", "w", "w", "w"],
#				["w", "w", "w", "w", "w", "w", "w"],
#				["w", "w", "w", "w", "w", "w", "w"],
#				["w", "w", "w", "w", "w", "w", "w"]]

func _set_tiles(grid):
	tiles = grid
