extends Control

onready var anim = $AnimationPlayer

func level_change_scene():
	get_tree().change_scene("res://nodes/Level.tscn")

func select_level():
	anim.play("Select Level")
