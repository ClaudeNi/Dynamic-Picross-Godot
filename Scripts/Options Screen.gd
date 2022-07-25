extends Control

onready var bg_slider = $Options/VolumeSliders/BackgroundMusic/BackgroundSlider
onready var bg_label = $Options/VolumeSliders/BackgroundMusic/BackgroundLabel
onready var se_slider = $Options/VolumeSliders/SoundEffects/SoundEffectsSlider
onready var se_label = $Options/VolumeSliders/SoundEffects/SoundEffectsLabel

onready var AreYouSure = $Options/Delete/AreYouSure
onready var HowTo = $Options/HowToPlay/HowTo

func _ready():
	update_BG()
	update_SE()
	AudioPlayer.play_BG_track(AudioPlayer.puzzle_bg)
	

func _on_NoBtn_pressed():
	AreYouSure.visible = false


func _on_YesBtn_pressed():
	Save.delete_data()
	update_BG()
	update_SE()
	AreYouSure.visible = false


func _on_DeleteBtn_pressed():
	AreYouSure.visible = true
	

func _on_HowCheckBox_toggled(button_pressed):
	if button_pressed:
		HowTo.visible = true
	else:
		HowTo.visible = false


func _on_BackgroundSlider_value_changed(value):
	bg_label.text = str(value * 10)
	AudioPlayer.set_BG_volume(linear2db(value))
	Save.game_data["bg_volume"] = value
	Save.save_data()


func _on_BackgroundSlider_mouse_exited():
	bg_slider.release_focus()


func _on_SoundEffectsSlider_value_changed(value):
	se_label.text = str(value * 10)
	AudioPlayer.set_SE_volume(linear2db(value))
	Save.game_data["se_volume"] = value
	Save.save_data()


func _on_SoundEffectsSlider_mouse_exited():
	se_slider.release_focus()


func update_BG():
	bg_slider.value = Save.game_data["bg_volume"]
	AudioPlayer.set_BG_volume(linear2db(bg_slider.value))
	bg_label.text = str(Save.game_data["bg_volume"] * 10)


func update_SE():
	se_slider.value = Save.game_data["se_volume"]
	AudioPlayer.set_SE_volume(linear2db(se_slider.value))
	se_label.text = str(Save.game_data["se_volume"] * 10)
