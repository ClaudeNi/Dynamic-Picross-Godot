extends Control

onready var anim = $AnimationPlayer
onready var camera = $Camera2D
onready var circle = $Circle

func _ready():
	anim.play("fade in")
	Globals.camera = camera
	Globals.circle = circle
	for btn in get_tree().get_nodes_in_group("Level_Btn"):
		btn.connect("pressed", self, "select_level", [btn])
	for node in get_tree().get_nodes_in_group("Color_Changer"):
		Globals.color_nodes.append(node)
		node.material.set("shader_param/NEWCELLCOLOR", Save.game_data["cell_color"])
		node.material.set("shader_param/NEWXCOLOR", Save.game_data["x_color"])
		node.material.set("shader_param/NEWNUMBERCOLOR", Save.game_data["number_color"])

func quit_game():
	get_tree().quit()	

func select_level(btn):
	Game.selected_puzzle = btn.PUZZLE_NAME
	anim.play("Select Level")

func reset_level():
	Game.reset_level()

func realign_level():
	Game.realign_level()

func _on_StartBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu1)
	anim.play("Start to Levels")


func _on_OptionsBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu1)
	anim.play("Start to Options")


func _on_QuitBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	anim.play("Quit Game")


func _on_LevelsGoBackBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	anim.play("Levels to Start")


func _on_OptionsGoBackBtn_pressed():
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	anim.play("Options to Start")


func _on_LevelBack_pressed():
	anim.play("Return from Level")
	AudioPlayer.play_SE_track(AudioPlayer.menu2)
	Levels.update_images()


#func _on_Button_pressed():
#	var new_lvl = lvl.duplicate()
#	new_lvl.get_children()[3].text = "test"
#	new_lvl.set_position(Vector2(0,0))
#	new_lvl.get_children()[2].connect("pressed", self, "pr")
#	lvls.add_child(new_lvl)
#func pr():
#	print("test")


func _on_FilledCellColorPicker_color_changed(color):
	color = color.to_html()
	print(color)
	for node in Globals.color_nodes:
		node.material.set("shader_param/NEWCELLCOLOR", color)
	Save.game_data["cell_color"] = color
	Save.save_data()


func _on_XCellColorPicker_color_changed(color):
	for node in Globals.color_nodes:
		node.material.set("shader_param/NEWXCOLOR", color)
	Save.game_data["x_color"] = color
	Save.save_data()
	

func _on_NumberCellColorPicker_color_changed(color):
	for node in Globals.color_nodes:
		node.material.set("shader_param/NEWNUMBERCOLOR", color)
	Save.game_data["number_color"] = color
	Save.save_data()
