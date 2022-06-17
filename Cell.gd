extends Node2D
onready var color = $"Color"

var state = "EMPTY" # EMPTY / FULL / CROSSED

func decide_Action():
	if not state == "EMPTY":
		color.color = Color(1,1,1,1)
		state = "EMPTY"
	elif Input.is_action_just_pressed("left_click"):
		color.color = Color(0,0,0,1)
		state = "FULL"
	elif Input.is_action_just_pressed("right_click"):
		color.color = Color(1,0,0,1)
		state = "CROSSED"

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and (Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("right_click")):
		decide_Action()
