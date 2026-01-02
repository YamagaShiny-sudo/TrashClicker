extends Node

var soundList = ["res://assets/Minimalistic Loops/loop.wav", "res://assets/Minimalistic Loops/loopTwo.wav", "res://assets/Minimalistic Loops/loopThree.wav"]
var idPlay = randi_range(0, 2)
var pitch = randf_range(0.990, 1.010)

@onready var background_music: AudioStreamPlayer = $BackgroundMusic
func _ready() -> void:
	background_music.stream = load("res://assets/Minimalistic Loops/buildup.wav")
	background_music.play()

func randomIdPlay() -> void:
	background_music.stream = load(soundList[idPlay])
	background_music.pitch_scale = pitch
	idPlay = randi() % 3
	background_music.play()

func _on_background_music_finished() -> void:
	randomIdPlay()
