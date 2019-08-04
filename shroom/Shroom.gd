extends Area2D

var is_bouncy : bool
export (int) var BouncyPower : int

func _on_Shroom_body_entered(body):
	if body.is_in_group("player") && $AnimatedSprite.animation == "fall":
		body.bounce(BouncyPower)

func Spring():
	$AnimatedSprite.animation = "spring"
	
func Summer():
	$AnimatedSprite.animation = "summer"
	
func Fall():
	$AnimatedSprite.animation = "fall"
	
func Winter():
	$AnimatedSprite.animation = "winter"