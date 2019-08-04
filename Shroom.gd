extends Sprite

var is_bouncy : bool
export (int) var BouncyPower : int

func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		body.bounce(BouncyPower)
