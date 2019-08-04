extends Area2D

var is_bouncy : bool
export (int) var BouncyPower : int

func _on_Shroom_body_entered(body):
	if body.is_in_group("player"):
		body.bounce(BouncyPower)
