extends Node2D

signal objective_got

export (int) var RotationOnAdvance : int = 90
export (PackedScene) var NextLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	_prepare_tween()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$Tween.start()
		
func GoToNextLevel():
	get_tree().change_scene_to(NextLevel)

func _on_Tween_tween_completed(object, key):
	_prepare_tween()

func _prepare_tween():
	$Tween.remove_all()
	$Tween.interpolate_property(self, "rotation_degrees", 
		rotation_degrees, 
		rotation_degrees + RotationOnAdvance, 5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Player, "rotation_degrees", 
		$Player.rotation_degrees, 
		$Player.rotation_degrees - RotationOnAdvance, 5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)