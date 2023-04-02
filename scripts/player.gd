extends Node2D

var player_name := ""
const HUMAN_CONTROL = preload("res://scenes/player_control_human.tscn")
var ai = false
var tile_color = Color()
var rng = RandomNumberGenerator.new()

func _ready():
	GameEvents.connect('new_player_selected', self, '_on_new_player_selected')
	_pass_human_control()
	rng.randomize()
	var rand_col_r = rng.randf_range(0, 1)
	var rand_col_g = rng.randf_range(0, 1)
	var rand_col_b = rng.randf_range(0, 1)
	tile_color = Color(rand_col_r, rand_col_g, rand_col_b)


func _pass_human_control():
	var controler = HUMAN_CONTROL.instance()
	self.add_child(controler)


func _on_new_player_selected(player):
	if player == self:
		if self.ai == true:
			print('Processing ai for....' + player.player_name)
			GameEvents.emit_signal('end_turn_pressed')
