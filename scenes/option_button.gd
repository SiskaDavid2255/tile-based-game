extends OptionButton


func _ready():
	add_item("Option 1", 0)
	add_item("Option 2", 1)
	add_item("Option 3", 2)
	select(2)
