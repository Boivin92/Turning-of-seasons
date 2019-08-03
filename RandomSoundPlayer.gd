extends Node

class_name RandomSoundPlayer

export (Array, AudioStream) var sounds

func play() -> void:
	if sounds.size() != 0:
		$AudioStreamPlayer.stream = sounds[ rand_range(0, sounds.size()) ]
		$AudioStreamPlayer.play()