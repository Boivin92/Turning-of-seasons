extends AnimatedSprite

export (PackedScene) var mainMenu

func _ready() -> void:
	$Tween.interpolate_property($Artists, "modulate", Color(0,0,0,0), Color(1,1,1,1), 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Programmers, "modulate", Color(0,0,0,0), Color(1,1,1,1), 5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_TextureButton_pressed() -> void:
	get_tree().change_scene_to(mainMenu)
