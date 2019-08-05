extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_TextureButton_toggled(button_pressed: bool) -> void:
	ActivateMusic(button_pressed)

func PlayLeverSound():
	$LeverSound.play()

func PlayRotationSound():
	$RotationSound.play()

func PlayEndingSound():
	$EndingSound.play()

func StopGraduallyMusic():
	$Tween.remove_all()
	$Tween.interpolate_property($AudioStreamPlayer, "volume_db", 
		$AudioStreamPlayer.volume_db, 
		$AudioStreamPlayer.volume_db - 90, 10, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func ActivateMusic(toggle : bool) -> void:
	var db : float
	if toggle:
		db = 0
	else:
		db = -90
	$AudioStreamPlayer.volume_db = db