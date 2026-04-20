extends Node

@export var soundList : Array[AudioStreamMP3]
var soundIcon = ["res://assets/soundOff.png", "res://assets/soundOn.png"]
var idPlay = randi_range(0, len(soundList)-1)
@onready var hud = get_node("HUD") 
var actif : int

@onready var end: Control = $End
@onready var background_music: AudioStreamPlayer = $BackgroundMusic
func _ready() -> void:
	actif = idPlay
	randomIdPlay()
	end.hide()


func randomIdPlay() -> void:
	idPlay = randi_range(0, len(soundList)-1)
	if actif == idPlay:
		if len(soundList)-1 < actif + 1:
			idPlay-=1
		else:
			idPlay+=1
	background_music.stream = soundList[idPlay]
	background_music.play()
	actif = idPlay

func _on_background_music_finished() -> void:
	randomIdPlay()

func _on_check_timer_timeout() -> void:
	if hud.trash_score >= 10**16:
		end.show()
		get_tree().paused = true

@onready var sound_mute: TextureButton = $BackgroundMusic/SoundMute
func _on_sound_mute_toggled(toggled_on: bool) -> void:
	if toggled_on:
		sound_mute.texture_normal = load(soundIcon[0])
		AudioServer.set_bus_mute(0, true)

	if not toggled_on:
		sound_mute.texture_normal = load(soundIcon[1])
		AudioServer.set_bus_mute(0, 0)
