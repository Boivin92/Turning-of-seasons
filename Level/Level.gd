extends Node2D

const Common = preload("res://Data/Common.gd")

export (int) var RotationOnAdvance : int = 90
export (PackedScene) var EndCard
export (Common.Season) var CurrentSeason

var NbOfTurn : int

# Called when the node enters the scene tree for the first time.
func _ready():
	_prepare_tween()
	CurrentSeason = Common.Season.Spring
	NbOfTurn = 0
	_change_blocks(CurrentSeason)
	_change_shrooms(CurrentSeason)
	_change_vines(CurrentSeason)

const FIXED = 17
const ROW = 40
func remap_tileset():
	for x in range(-35, 35):
		for y in range(-35, 35):
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

func GoToEndCard():
	get_tree().change_scene_to(EndCard)

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
			Common.Season.Summer:
				CurrentSeason =  Common.Season.Fall
			Common.Season.Fall:
				CurrentSeason =  Common.Season.Winter
			Common.Season.Winter:
				NbOfTurn += 1
				if NbOfTurn == 2 :
					CurrentSeason = Common.Season.End
				else :
					CurrentSeason =  Common.Season.Spring
					$ObjectiveSpring.reset_objective()
					$ObjectiveSummer.reset_objective()
					$ObjectiveFall.reset_objective()
		
		if NbOfTurn == 2 :
			$Player.brace_character()
			music.StopGraduallyMusic()
			music.PlayEndingSound()
			GoToEndCard()
		else :
			_change_blocks(CurrentSeason)
			_change_shrooms(CurrentSeason)
			_change_vines(CurrentSeason)
			$Tween.start()
			music.PlayRotationSound()
			$Player.brace_character()
			_activate_particles(true)
			remap_tileset()

func _on_ClimbingBlock_body_entered(body):
	if body.is_in_group("player"):
		body.is_on_ladder = true

func _change_shrooms(season):
	for shroom in $Shrooms.get_children():
		match season:
			Common.Season.Spring:
				shroom.Spring()
			Common.Season.Summer:
				shroom.Summer()
			Common.Season.Fall:
				shroom.Fall()
			Common.Season.Winter:
				shroom.Winter()
	
				
func _change_blocks(season):
	for block in $CrumblingBlocks.get_children():
		match season:
			Common.Season.Spring:
				block.Spring()
			Common.Season.Summer:
				block.Summer()
			Common.Season.Fall:
				block.Fall()
			Common.Season.Winter:
				block.Winter()

func _change_vines(season):
	for vine in $vignes.get_children():
		for node in vine.get_children():
			if not node is CollisionShape2D:
				if node.name == "ClimbingPart1":
					match season:
						Common.Season.Spring:
							node.Spring()
						Common.Season.Summer:
							node.Summer()
						Common.Season.Fall:
							node.Fall()
						Common.Season.Winter:
							node.Winter()
				else:
					if season == Common.Season.Summer:
						node.visible = true
					else:
						node.visible = false
			else:
				if season == Common.Season.Summer:
					node.disabled  = false
				else:
					node.disabled  = true

func _on_ClimbingBlock_body_exited(body):
	if body.is_in_group("player"):
		body.is_on_ladder = false
