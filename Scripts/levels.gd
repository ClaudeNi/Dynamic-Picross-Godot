extends Node

func select_puzzle(key):
	match(key):
		"bunny":
			return "res://assets/puzzles/bunny.png"
		"target":
			return "res://assets/puzzles/target.png"
