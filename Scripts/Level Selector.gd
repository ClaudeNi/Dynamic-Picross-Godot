extends Node2D

export var PUZZLE_NAME = ""

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	Game.selected_puzzle = PUZZLE_NAME
	print("pressed " + Game.selected_puzzle)
	pass # Replace with function body.
