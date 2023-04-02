extends Node2D

var grid = [[]]
var my_res2 = preload("res://resources/my_res2.tres")
var a = 4 # one side of square in px
var size = Vector2(a, a)
var cam_rect = Rect2(Vector2(0, 0), Vector2(38, 18))
var cam_rect_color = Color(1, 0, 0) 
var tile_size = 128
var tile_selected = Vector2()



func _ready():
	_set_grid(GameManager.grid_structure)
	GameEvents.connect("cam_moved", self, "_on_cam_moved")
	GameEvents.connect("tile_size_changed", self, "_on_tile_size_changed")
	GameEvents.connect("tile_selected", self, "_on_tile_selected")
	
func _draw():

	var x = 0
	var y = 0

	for line in grid:
		for tile in line:
				var pos = Vector2(x, y)
				var rect = Rect2(pos, size)
				var color = Color()
				if tile.terrain == "w":
					color = Color(0.4, 0.2, 0.8)
				elif tile.terrain == "g":
					color = Color(0.3, 0.8, 0.4)
				draw_rect(rect, color)
				x += a
		y += a
		x = 0
	
	if tile_selected: 
		var select_rect = Rect2(tile_selected*size, size)
		draw_rect(select_rect, Color(1, 0, 0))

	draw_rect(cam_rect, cam_rect_color, false, 2)		
		
func _set_grid(new_grid):
	grid = new_grid
	
func _on_cam_moved(cam_pos):
	cam_pos = cam_pos/tile_size*a
	cam_rect.position = cam_pos

func _process(delta):
	update()

func _on_tile_size_changed(size):
	tile_size = size
	if tile_size == 128:
		cam_rect.size = Vector2(38, 18)
	else:
		cam_rect.size = Vector2(76, 36)
	
func _on_tile_selected(tile):
	tile_selected.x = tile.x
	tile_selected.y = tile.y
