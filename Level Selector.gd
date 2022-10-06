extends Control

onready var btn = $Button
onready var sprite = $sprite
onready var label = $Label

onready var texture_link = load(Levels.select_puzzle(btn.PUZZLE_NAME))
onready var scales = {
	"10": 15,
	"15": 10,
	"20": 8,
}

func _ready():
	add_to_group("Level")
	if Save.game_data["beaten_levels"].has(btn.PUZZLE_NAME):
		sprite.texture = texture_link
		texture_link.get_data().lock()
		var WIDTH = str(texture_link.get_width())
		sprite.scale.x = scales[WIDTH]
		sprite.scale.y = scales[WIDTH]
		label.text = btn.PUZZLE_NAME.capitalize()
	else:
		label.text += str(btn.LEVEL_NUMBER)
		
func update_image():
	if Save.game_data["beaten_levels"].has(btn.PUZZLE_NAME):
		sprite.texture = texture_link
		label.text = btn.PUZZLE_NAME.capitalize()
	else:
		sprite.texture = load("res://assets/question.png")
		label.text = "Level " + str(btn.LEVEL_NUMBER)
