extends CanvasLayer

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TextureButton_toggled(button_pressed: bool) -> void:
	ActivateMusic(button_pressed)

func PlayLeverSound():
	$LeverSound.play()
	
func PlayRotationSound():
	$RotationSound.play()

func ActivateMusic(toggle : bool) -> void:
	var db : float
	if toggle:
		db = 0
	else:
		db = -90
	$AudioStreamPlayer.volume_db = db