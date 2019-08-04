extends CanvasLayer

export (Texture) var spring_icon
export (Texture) var summer_icon
export (Texture) var autumn_icon
export (Texture) var winter_icon

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_1):
		Spring()
	if Input.is_key_pressed(KEY_2):
		Summer()
	if Input.is_key_pressed(KEY_3):
		Autumn()
	if Input.is_key_pressed(KEY_4):
		Winter()

func Spring():
	$Particles2D.emitting = false
	$Particles2D.texture = spring_icon
	$Particles2D.emitting = true
	
func Summer():
	$Particles2D.emitting = false
	$Particles2D.texture = summer_icon
	$Particles2D.emitting = true
	
func Autumn():
	$Particles2D.emitting = false
	$Particles2D.texture = autumn_icon
	$Particles2D.emitting = true
	
func Winter():
	$Particles2D.emitting = false
	$Particles2D.texture = winter_icon
	$Particles2D.emitting = true