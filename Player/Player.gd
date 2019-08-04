extends KinematicBody2D

var velocity : Vector2 = Vector2()
export (int) var gravity : int
export (int) var run_speed : int
export (int) var jump_speed : int
export (int) var climb_speed : int

var braced : bool = false
var is_on_ladder = false
var interact : bool = false

const IDLE = "idle"
const WALK = "walk"
const JUMP = "jump"
const FALL = "fall"
const CLIMB = "climb"
const BRACE = "idle"

signal stomped

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func brace_character():
	braced = true
	
func release_bracing():
	braced = false

func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	elif !is_on_ladder:
		velocity.y += gravity * delta
	
	if not braced:
		get_input()
	
	velocity.y = clamp(velocity.y, -2000, 2000)
	var airborne = not is_on_floor()
	
	var slide = move_and_slide(velocity, Vector2(0, -1), false, 4, 0.523599)
	if velocity.y < 0 && slide.y >= 0:
		velocity.y =0
	_set_sprite(slide)
	
	if airborne && is_on_floor() && velocity.y > 50:
		_shake_camera()
		
	var raycastReturn = $RayCast2D.get_collider()
	if raycastReturn != null:
		if raycastReturn.is_in_group("breakable"):
			raycastReturn.crumble()
		if raycastReturn.is_in_group("interactible") && interact:
			raycastReturn.interact()
		
func _set_sprite(slide: Vector2) -> void:
	if braced:
		$AnimatedSprite.play(BRACE)
		return

	if slide.x < 0:
		$AnimatedSprite.flip_h = true
	elif slide.x > 0:
		$AnimatedSprite.flip_h = false

	var anim = IDLE
	if slide.x != 0:
		anim = WALK
	if slide.y < 0:
		anim = JUMP
	if slide.y > 0:
		anim = FALL
	if is_on_ladder and slide.y != 0:
		anim = CLIMB
	$AnimatedSprite.play(anim)

func bounce(bouncyPower : int):
	if not is_on_floor() && velocity.y > 0:
		velocity.y = -bouncyPower

func _shake_camera():
	$Camera2DWithShake.shake(0.4, 15, 8)
	emit_signal("stomped")
	
func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	var climb = Input.is_action_pressed("climb")
	interact = Input.is_action_pressed("interact")
	
	velocity.x = 0
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	if jump && is_on_floor() && !is_on_ladder:
		velocity.y = -jump_speed
	if climb && is_on_ladder:
		velocity.y = -climb_speed

func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "walk":
		if $AnimatedSprite.frame == 0 || $AnimatedSprite.frame == 3:
			$RandomSoundPlayer.play()
