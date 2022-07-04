extends Node2D

export var PUZZLE_NAME = ""
export var PUZZLE_NUMBER = 0

onready var texture_link = load(Levels.select_puzzle(PUZZLE_NAME))

onready var sprite = $sprite
onready var label = $Label


func _ready():
	if Save.game_data["beaten_levels"].has(PUZZLE_NAME):
		sprite.texture = texture_link
		label.text = PUZZLE_NAME.capitalize()
	else:
		label.text += str(PUZZLE_NUMBER)
		

func _on_Button_pressed():
	Game.selected_puzzle = PUZZLE_NAME
	get_tree().change_scene("res://nodes/Main.tscn")
