extends Node2D

signal objective_got

const Common = preload("res://Data/Common.gd")

export (int) var RotationOnAdvance : int = 90
export (PackedScene) var NextLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	_prepare_tween()

func remap_tileset():
	for x in range(-10, 10):
		for y in range(-10, 10):
			var cell = $TileMap.get_cell(x, y)
			if (cell != $TileMap.INVALID_CELL):
				$TileMap.set_cell(x, y, (cell + 18) % 36)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$Tween.start()
		$Player.brace_character()
		_activate_particles(true)
		#remap_tileset()
		
		
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


func _on_ObjectiveSpring_body_entered(body: PhysicsBody2D) -> void:
	turn_season(Common.Season.Spring)


func _on_ObjectiveSummer_body_entered(body: PhysicsBody2D) -> void:
	turn_season(Common.Season.Summer)


func _on_ObjectiveFall_body_entered(body: PhysicsBody2D) -> void:
	turn_season(Common.Season.Fall)


func _on_ObjectiveWinter_body_entered(body: PhysicsBody2D) -> void:
	turn_season(Common.Season.Winter)

func turn_season(season):
	pass
