extends StaticBody2D

func _on_Timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	$Sprite.frame = 0

func crumble():
	$AnimationPlayer.play("breaking")