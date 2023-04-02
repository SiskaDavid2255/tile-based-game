extends Node2D

const PLAYER = preload("res://scenes/player.tscn")

var player_current
var player_index = 0
var players = []
var round_no = 1
export var no_of_players: int


func _ready():
	GameEvents.connect('end_turn_pressed', self, '_end_turn')
	_load_game_state_data()
	_generate_players(no_of_players)
	_select_player()


func _load_game_state_data():
	no_of_players = GameManager.params.players

func _generate_players(no_of_players):
	for no in range(no_of_players):
		_create_player(no)
	GameEvents.emit_signal("players_generated", players)		

func _create_player(no):
	var new_player = PLAYER.instance()
	new_player.player_name = "Player " + str(no)
	self.add_child(new_player)
	players.append(new_player)
	_set_players_to_ai()

func _set_players_to_ai():
	for p in players:
		p.ai = true
	players[0].ai = false

func _select_player():
	player_current = players[player_index]

func _next_player():
	if player_index < len(players)-1:
		player_index += 1
	else:
		_end_round()
		player_index = 0
	player_current = players[player_index]
	GameEvents.emit_signal("new_player_selected", player_current)

func _end_turn():
	_next_player()
	
func _end_round():
	round_no += 1
	GameEvents.emit_signal("round_ended", round_no)



