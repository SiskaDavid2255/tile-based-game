extends CanvasLayer


onready var label = get_node("Control2/Label")
onready var label_2 = get_node("Control/Label2")
onready var label_3 = get_node("Control2/Label3")

func _ready():
	GameEvents.connect("round_ended", self, "_on_round_ended")
	GameEvents.connect("tile_selected", self, "_on_tile_selected")
	GameEvents.connect("new_player_selected", self, "_on_new_player_selected")
	
func _on_EndTurnButton_pressed():
	GameEvents.emit_signal("end_turn_pressed")

func _on_round_ended(round_no: int):
	label.text = "Round: " + str(round_no)
	label_2.text = "Tile: no tile"
	
func _on_tile_selected(tile):
	label_2.text = "Tile: " + str(tile.x) + "," +str(tile.y) + "; Terrain: " + tile.terrain

func _on_new_player_selected(player):
	label_3.text = "Player: " + player.player_name

