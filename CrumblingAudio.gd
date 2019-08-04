extends Control

var busy : bool = false

func PlayWithoutOverride():
	if not busy :
		$RandomSoundPlayer.play()
		busy = true

func _on_AudioStreamPlayer_finished() -> void:
	busy = false
