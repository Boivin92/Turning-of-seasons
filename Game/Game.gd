extends Node2D

func _ready():
	_prepare_tween()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$Tween.start()

func _on_Tween_tween_completed(object, key):
	_prepare_tween()

func _prepare_tween():
	$Tween.remove_all()
	$Tween.interpolate_property($Level, "rotation_degrees", 
		$Level.rotation_degrees, 
		$Level.rotation_degrees + 90, 5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)