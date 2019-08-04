extends Node2D

const Common = preload("res://Data/Common.gd")

export (int) var RotationOnAdvance : int = 90
export (PackedScene) var NextLevel
export (Common.Season) var CurrentSeason

var NbOfTurn : int

# Called when the node enters the scene tree for the first time.
func _ready():
	_prepare_tween()
	CurrentSeason = Common.Season.Spring
	NbOfTurn = 0

const FIXED = 17
const ROW = 31
func remap_tileset():
	for x in range(-10, 10):
		for y in range(-10, 10):
			var cell = $TileMap.get_cell(x, y)
			if cell >= FIXED:
				cell += ROW
				if cell >= FIXED + 4*ROW:
					cell -= 4*ROW
				$TileMap.set_cell(x, y, cell)

func _process(delta):
	pass

func _activate_particles(emit : bool) -> void:
	$particles/ParticlesBottom.emitting = emit
	$particles/ParticlesTop.emitting = emit
	$particles/ParticlesLeft.emitting = emit
	$particles/ParticlesRight.emitting = emit

func GoToNextLevel():
	get_tree().change_scene_to(NextLevel)

func _on_Tween_tween_completed(object, key):
	_prepare_tween()
	$Player.release_bracing()
	_activate_particles(false)

func _prepare_tween():
	$Tween.remove_all()
	$Tween.interpolate_property(self, "rotation_degrees", 
		rotation_degrees, 
		rotation_degrees + RotationOnAdvance, 5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($Player, "rotation_degrees", 
		$Player.rotation_degrees, 
		$Player.rotation_degrees - RotationOnAdvance, 5, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

func _on_Player_stomped() -> void:
	_activate_particles(true)
	$Timer.start()

func _on_Timer_timeout() -> void:
	_activate_particles(false)

func _on_Objective_activated(season):
	if CurrentSeason == season :
		match season :
			Common.Season.Spring:
				CurrentSeason =  Common.Season.Summer
				$ObjectiveWinter.reset_objective()
				$ClimbingBlock1/CollisionShape2D.disabled = false
				$ClimbingBlock1/ClimbingPart1/AnimatedSprite.play("Summer_Base")
				$ClimbingBlock1/ClimbingPart2.visible = true
				$ClimbingBlock1/ClimbingPart2/AnimatedSprite.play("Summer_Body_A")
				$ClimbingBlock1/ClimbingPart3.visible = true
				$ClimbingBlock1/ClimbingPart3/AnimatedSprite.play("Summer_Head_B")
			Common.Season.Summer:
				CurrentSeason =  Common.Season.Fall
				$ClimbingBlock1/CollisionShape2D.disabled = true
				$ClimbingBlock1/ClimbingPart1/AnimatedSprite.play("Fall")
				$ClimbingBlock1/ClimbingPart2.visible = false
				$ClimbingBlock1/ClimbingPart3.visible = false
			Common.Season.Fall:
				CurrentSeason =  Common.Season.Winter
				$ClimbingBlock1/CollisionShape2D.disabled = true
				$ClimbingBlock1/ClimbingPart1/AnimatedSprite.play("Winter")
				$ClimbingBlock1/ClimbingPart2.visible = false
				$ClimbingBlock1/ClimbingPart3.visible = false
			Common.Season.Winter:
				NbOfTurn += 1
				if NbOfTurn == 2 :
					CurrentSeason = Common.Season.End
				else :
					CurrentSeason =  Common.Season.Spring
					$ClimbingBlock1/ClimbingPart1/AnimatedSprite.play("Spring")
					$ObjectiveSpring.reset_objective()
					$ObjectiveSummer.reset_objective()
					$ObjectiveFall.reset_objective()
		
		if NbOfTurn == 2 :
			$Player.brace_character()
			music.StopGraduallyMusic()
			music.PlayEndingSound()
		else :
			$Tween.start()
			music.PlayRotationSound()
			$Player.brace_character()
			_activate_particles(true)
			remap_tileset()

func _on_ClimbingBlock_body_entered(body):
	if body.is_in_group("player"):
		body.is_on_ladder = true

func _on_ClimbingBlock_body_exited(body):
	if body.is_in_group("player"):
		body.is_on_ladder = false
