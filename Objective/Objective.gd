extends Area2D

const Season = preload("res://Data/Common.gd")
export (Season.Season) var type
var activated = false

signal activated(season)

func get_animation_name() -> String:
	match type:
		Season.Season.Spring:
			return "spring"
		Season.Season.Summer:
			return "summer"
		Season.Season.Fall:
			return "fall"
		Season.Season.Winter:
			return "winter"
		_:
			return ""

func _ready() -> void:
	$AnimatedSprite.set_animation(get_animation_name())


func _on_Objective_body_entered(body: PhysicsBody2D) -> void:
	if body && !activated && get_parent().CurrentSeason == type:
		activated = true
		$AnimatedSprite.play()
		music.PlayLeverSound()


func _on_AnimatedSprite_animation_finished() -> void:
	emit_signal("activated", type)
