extends Node2D

onready var audioSF = $"Sound Effects Player"
onready var audioBG = $"Background Player"

onready var puzzle_bg = load("res://assets/audio/puzzle-1-a.wav")

onready var menu1 = load("res://assets/audio/click.wav")
onready var menu2 = load("res://assets/audio/click2.wav")
onready var fill = load("res://assets/audio/fill.wav")

func play_SF_track(track):
	audioSF.stream = track
	audioSF.play()

func play_BG_track(track):
	audioBG.stream = track
	audioBG.play()
