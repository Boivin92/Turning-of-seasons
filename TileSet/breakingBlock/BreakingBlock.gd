extends StaticBody2D

export (Texture) var springTexture
export (Texture) var summerTexture
export (Texture) var autumnTexture
export (Texture) var winterTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func crumble():
	$AnimationPlayer.play("breaking")

func _on_Timer_timeout() -> void:
	$CollisionShape2D.disabled = false
	$Sprite.frame = 0