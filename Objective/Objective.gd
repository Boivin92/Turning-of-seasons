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

func reset_objective() -> void:
	activated = false
	$AnimatedSprite.stop()
	$AnimatedSprite.frame = 0

func _ready() -> void:
	$AnimatedSprite.set_animation(get_animation_name())

func interact() -> void:
	if not activated && get_parent().CurrentSeason == type:
		activated = true
		$AnimatedSprite.play()
		music.PlayLeverSound()


func _on_AnimatedSprite_animation_finished() -> void:
	emit_signal("activated", type)
