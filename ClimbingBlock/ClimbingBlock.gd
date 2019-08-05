extends Node2D

const Vines = preload("res://Data/Common.gd")
export (Vines.Vines) var type

# Called when the node enters the scene tree for the first time.
func _ready():
	match type:
		Vines.Vines.Spring:
			$AnimatedSprite.set_animation("Spring")
		Vines.Vines.Fall:
			$AnimatedSprite.set_animation("Fall")
		Vines.Vines.Winter:
			$AnimatedSprite.set_animation("Winter")
		Vines.Vines.Summer:
			$AnimatedSprite.set_animation("Summer")
		Vines.Vines.SummerBodyA:
			$AnimatedSprite.set_animation("Summer_Body_A")
		Vines.Vines.SummerBodyB:
			$AnimatedSprite.set_animation("Summer_Body_B")
		Vines.Vines.SummerHeadA:
			$AnimatedSprite.set_animation("Summer_Head_A")
		Vines.Vines.SummerHeadB:
			$AnimatedSprite.set_animation("Summer_Head_B")
		_:
			return ""
			
func Spring():
	$AnimatedSprite.set_animation("Spring")
	
func Summer():
	$AnimatedSprite.set_animation("Summer")
	
func Fall():
	$AnimatedSprite.set_animation("Fall")
	
func Winter():
	$AnimatedSprite.set_animation("Winter")