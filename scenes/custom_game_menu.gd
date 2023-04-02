extends MarginContainer

onready var map_size_btn = get_node("VBoxContainer/MapSizeBtn")
onready var opponents_count_btn = get_node("VBoxContainer/OpponentsCountBtn")
export var max_opponents = 12


var size_otpions_array = [Vector2(8, 16), Vector2(16, 32), 
Vector2(27, 54), Vector2(40, 80), Vector2(50,100)]

func _ready():
	_initialize_map_size_btn()
	_initialize_opponents_count_btn()
	
func _initialize_map_size_btn():
	map_size_btn.add_item("Tiny (8x16)", 0)
	map_size_btn.add_item("Small (16x32)", 1)
	map_size_btn.add_item("Normal (27x54)", 2)
	map_size_btn.add_item("Large (40x80)", 3)
	map_size_btn.add_item("Huge (50x100)", 4)
	map_size_btn.select(2)

func _initialize_opponents_count_btn():
	opponents_count_btn.add_item("Single opponent", 0)
	for no in range(1, max_opponents):
		opponents_count_btn.add_item(str(no + 1) + " opponents", no)
	opponents_count_btn.select(5)
	
func _on_StartButton_pressed():
	var players = opponents_count_btn.selected + 1
	var size = size_otpions_array[map_size_btn.selected]
	GameManager.new_game(players, size, [["w", "w"]])

func _on_BackButton_pressed():
	var parent = get_parent()
	if parent.name == "MainMenu":
		self.visible = false
		parent.main_menu_container.visible = true



	
	
	
	
