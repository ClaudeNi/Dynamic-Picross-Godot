extends Node

var beaten_levels = []

var link = "res://assets/puzzles/"

func select_puzzle(key):
	return (link + key + ".png")

func update_images():
	for node in get_tree().get_nodes_in_group("Level"):
		node.update_image()
