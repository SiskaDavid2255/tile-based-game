extends Node2D

export var cam_speed = 12
var tile_size = 128 #px
var map_size = Vector2(54*tile_size, 27*tile_size)
var viewport_size = Vector2(1024, 600)


func _process(delta):
	
	if Input.is_action_pressed("ui_left"):
		self.position.x -= cam_speed
		GameEvents.emit_signal("cam_moved", self.position)
	
		if (self.position.x) < 0:
			if (self.position.x) < -(viewport_size.x):
				self.position.x = map_size.x-viewport_size.x
			
	if Input.is_action_pressed("ui_right"):
		self.position.x += cam_speed
		GameEvents.emit_signal("cam_moved", self.position)
		if (self.position.x + viewport_size.x) > map_size.x:
			if (self.position.x) > map_size.x:
				self.position.x = 0
			
	if Input.is_action_pressed("ui_up"):
		if position.y > 0:
			self.position.y -= cam_speed
			GameEvents.emit_signal("cam_moved", self.position)

	if Input.is_action_pressed("ui_down"):
		if position.y < (map_size.y-viewport_size.y):
			self.position.y += cam_speed
			GameEvents.emit_signal("cam_moved", self.position)
	
	if Input.is_action_pressed("zoom_in"):
		if tile_size == 128:
			pass
		elif tile_size == 64:
			tile_size = 128
			self.position *= 2
			GameEvents.emit_signal('tile_size_changed', tile_size)
			print('change size to' + str(tile_size))
		else:
			print('Unkown tile size.')
	
	if Input.is_action_pressed("zoom_out"):
		if tile_size == 64:
			pass
		elif tile_size == 128:
			tile_size = 64
			self.position /= 2
			GameEvents.emit_signal('tile_size_changed', tile_size)
			print('change size to' + str(tile_size))
		else:
			print('Unkown tile size.')
			
func _input(event):

	if event.is_action_pressed("left_click"):
		var mouse_pos = get_viewport().get_mouse_position()
		var global_mouse_pos = get_global_mouse_position()
		var viewport_offset = mouse_pos - global_mouse_pos
		var grid_pos = (mouse_pos - viewport_offset)/tile_size
		var grid_pos_floored = Vector2(floor(grid_pos.x), floor(grid_pos.y))
		if (grid_pos_floored.x <= 53) && (grid_pos_floored.x >= 0):
				if (grid_pos_floored.y <= 53) && (grid_pos_floored.y >= 0):
					GameEvents.emit_signal("tile_clicked_left", grid_pos_floored)
					
	if event.is_action_pressed("right_click"):
		var mouse_pos = get_viewport().get_mouse_position()
		var global_mouse_pos = get_global_mouse_position()
		var viewport_offset = mouse_pos - global_mouse_pos
		var grid_pos = (mouse_pos - viewport_offset)/tile_size
		var grid_pos_floored = Vector2(floor(grid_pos.x), floor(grid_pos.y))
		if (grid_pos_floored.x <= 26) && (grid_pos_floored.x >= 0):
				if (grid_pos_floored.y <= 26) && (grid_pos_floored.y >= 0):
					GameEvents.emit_signal("tile_clicked_right", grid_pos_floored)
