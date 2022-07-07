extends Control

onready var fade_control = $Fade

func _ready():
	if Save.first_time_loading:
		Save.load_data()
	else:
		fade_control.visible = false
