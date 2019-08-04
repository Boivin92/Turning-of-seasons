tool
extends Node

class_name RandomSoundPlayer

export (Array, AudioStream) var sounds

func _get_configuration_warning() -> String:
	for child in get_children():
		if child is AudioStreamPlayer:
			return ""
	return "An AudioStreamPlayer must be assigned as a child!"

func play() -> void:
	if sounds.size() != 0:
		$AudioStreamPlayer.stream = sounds[ rand_range(0, sounds.size()) ]
		$AudioStreamPlayer.play()