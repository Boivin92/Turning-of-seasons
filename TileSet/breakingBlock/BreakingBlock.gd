extends StaticBody2D


func _on_Timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	$Sprite.frame = 0
	$Sprite.playing = false

func crumble():
	if $Sprite.animation == "winter":
		$Sprite.playing = true
		CrumblingAudio.PlayWithoutOverride()

func _on_Sprite_animation_finished() -> void:
	$Timer.start()
	$CollisionShape2D.disabled = true
	
func Spring():
	$Sprite.animation = "spring"
	
func Summer():
	$Sprite.animation = "summer"
	
func Fall():
	$Sprite.animation = "fall"
	
func Winter():
	$Sprite.animation = "winter"