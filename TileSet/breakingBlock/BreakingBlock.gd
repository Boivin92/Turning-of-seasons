extends StaticBody2D

func _on_Timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	$Sprite.frame = 0
	$Sprite.playing = false

func crumble():
	$Sprite.playing = true
	CrumblingAudio.PlayWithoutOverride()

func _on_Sprite_animation_finished() -> void:
	$Timer.start()
	$CollisionShape2D.disabled = true