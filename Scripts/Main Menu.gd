extends Control

onready var btn1 = $Button

func _ready():
	Save.load_data()

func _on_Button_pressed():
	get_tree().change_scene("res://nodes/Level Selection Screen.tscn")


func _on_Button2_pressed():
	get_tree().quit()


func _on_Button_mouse_entered():
	pass # Replace with function body.
