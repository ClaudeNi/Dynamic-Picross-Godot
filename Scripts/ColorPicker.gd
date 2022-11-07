extends ColorPickerButton

export var changer = ""

func _ready():
	var new_color = ""
	match changer:
		"cell":
			new_color = Save.game_data["cell_color"]
		"x":
			new_color = Save.game_data["x_color"]
		"number":
			new_color = Save.game_data["number_color"]
	color = new_color

