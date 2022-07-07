extends Node2D

onready var audioSE = $"Sound Effects Player"
onready var audioBG = $"Background Player"

onready var puzzle_bg = load("res://assets/audio/puzzle-1-a.wav")

onready var menu1 = load("res://assets/audio/click.wav")
onready var menu2 = load("res://assets/audio/click2.wav")
onready var fill = load("res://assets/audio/fill.wav")

func play_SE_track(track):
	audioSE.stream = track
	audioSE.play()

func play_BG_track(track):
	audioBG.stream = track
	audioBG.play()

func set_BG_volume(value):
	audioBG.volume_db = value

func set_SE_volume(value):
	audioSE.volume_db = value
