extends Control

onready var lvls_grid = $"LevelsMenu/VBoxContainer/HBoxContainer/Levels/GridBox"

var num_grid = 1
var current_grid = 1
var grid_width = 640

func _ready():
	num_grid = lvls_grid.get_child_count()

func _on_LevelsBack_pressed():
	if current_grid > 1:
		current_grid -= 1
		lvls_grid.rect_position.x += grid_width


func _on_LevelsNext_pressed():
	if current_grid < num_grid:
		current_grid += 1
		lvls_grid.rect_position.x -= grid_width
