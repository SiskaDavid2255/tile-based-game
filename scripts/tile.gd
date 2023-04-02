extends Node2D


var x :int
var y :int
var agent
var city
var player = null
var terrain

func _ready():
	pass 

func give_self_to_player(player):
	player = player
	var sprite = self.get_node('Sprite')
	sprite.modulate = player.tile_color
	
