extends Node2D

export var PUZZLE_NAME = ""

func _on_Button_pressed():
	Game.selected_puzzle = PUZZLE_NAME
	get_tree().change_scene("res://nodes/Main.tscn")
