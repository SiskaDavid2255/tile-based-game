extends Node2D

export var size = Vector2()
const TILE = preload("res://scenes/tile.tscn")
var tiles_structure = []
var tile_selected = null
var rng = RandomNumberGenerator.new()
var tile_size = 128 # pixels
const TEXTURE_WATER = preload("res://resources/water_test.png")
var test_grid_res = preload("res://resources/my_res2.tres")

func _ready():
	GameEvents.connect("tile_clicked_left", self, "_on_tile_clicked_left")
	GameEvents.connect("tile_clicked_right", self, "_on_tile_clicked_right")
	GameEvents.connect("new_player_selected", self, "_on_new_player_selected")
	GameEvents.connect('players_generated', self, '_on_players_generated')
	GameEvents.connect('tile_size_changed', self, '_on_tile_size_changed')
	size = GameManager.params.grid_size
	rng.randomize()
	_generate_grid()

func _generate_grid():
	var _line = []
	var _x = 0
	var _y = 0
	
	for x in range(size.x):
		for y in range(size.y):
			var new_tile = TILE.instance()
			new_tile.x = _x
			new_tile.y = _y
			new_tile.terrain = "g"
			new_tile.set_position(Vector2(_x, _y) * tile_size)
			self.add_child(new_tile)
			_line.append(new_tile)
			_x += 1
		tiles_structure.append(_line)
		_x = 0
		_y += 1
		_line = []
	_test_water()
	GameManager.grid_structure = tiles_structure		

func _on_tile_clicked_left(tile_pos):
	if tile_selected != null:
		var sprite_0 = tile_selected.get_node('Sprite')
		sprite_0.modulate = Color(1, 1, 1)
	tile_selected = tiles_structure[tile_pos.y][tile_pos.x]
	var sprite = tile_selected.get_node('Sprite')
#	tile_selected.visible = false
	sprite.modulate = Color(0, 0, 1)
	GameEvents.emit_signal("tile_selected", tile_selected)
#	if tile_selected.agent:
#		agent = tile_selected.agent

		
func _on_tile_clicked_right(tile_pos):
	if tile_selected != null:
		print('Tile xy should do something')

func _on_new_player_selected(round_no):
	if tile_selected != null:
		var sprite_0 = tile_selected.get_node('Sprite')
		sprite_0.modulate = Color(1, 1, 1)
	tile_selected = null
	
func _on_players_generated(players):
		pass
		

func _on_tile_size_changed(new_size):
	_redraw_grid(new_size)
	
func _redraw_grid(new_size):

	print('redrawing')
	for line in tiles_structure:
		for tile in line:
			tile.set_position(Vector2(tile.x, tile.y) * new_size)
			var sprite = tile.get_node("Sprite")
			if new_size == 128:
				sprite.set_scale(Vector2(1, 1))
			elif new_size == 64:
				sprite.set_scale(Vector2(0.5, 0.5))


func _test_water():
	for x in range(5, 10):
		var sprite = tiles_structure[x][2].get_node("Sprite")
		sprite.texture = TEXTURE_WATER
		tiles_structure[x][2].terrain = "w"
	
	for y in range(0, 10):
		var sprite = tiles_structure[5][y].get_node("Sprite")
		sprite.texture = TEXTURE_WATER
		tiles_structure[5][y].terrain = "w"
	

func _set_tile_to_terrain(x, y):
	print('h')


func _generate_grid_from_tres(grid_tres):
	
	var _line = []
	var _x = 0
	var _y = 0
	
	for line in grid_tres.tiles:
		for tile in line:
			var new_tile = TILE.instance()
			new_tile.x = _x
			new_tile.y = _y
			new_tile.set_position(Vector2(_x, _y) * tile_size)
			_set_tile_terrain(tile, new_tile)
			self.add_child(new_tile)
			_line.append(new_tile)
			_x += 1
		tiles_structure.append(_line)
		_x = 0
		_y += 1
		_line = []

func _set_tile_terrain(tile, new_tile):
	var sprite = new_tile.get_node('Sprite')
	if tile == 'w':
		new_tile.terrain = 'w'
		sprite.texture = TEXTURE_WATER
	elif tile == 'g':
		new_tile.terrain = 'g'
	else:
		pass
