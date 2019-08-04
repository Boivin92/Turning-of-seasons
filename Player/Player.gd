extends KinematicBody2D

var velocity : Vector2 = Vector2()
export (int) var gravity : int
export (int) var run_speed : int
export (int) var jump_speed : int
export (int) var climb_speed : int

var pounding : bool
var available : bool = true
var is_on_ladder = false

signal stomped

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func brace_character():
	available = false
	$AnimatedSprite.play("idle") # TODO remplacer par "brace"
	
func release_bracing():
	available = true

func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	elif !is_on_ladder:
		velocity.y += gravity * delta
	
	if not pounding && available:
		get_input()
	
	velocity.y = clamp(velocity.y, -2000, 2000)
	var airborne = not is_on_floor()
	
	var slide = move_and_slide(velocity, Vector2(0, -1), false, 4, 0.523599)
	_set_sprite(slide)
	if airborne && is_on_floor() && velocity.y > 50:
		_shake_camera()
		
	if pounding && is_on_floor():
		pounding = false
		
		
func _set_sprite(slide: Vector2) -> void:
	if !available:
		return

	if slide.x == 0:
		$AnimatedSprite.play("idle")
		print("Play Idle")
	else:
		$AnimatedSprite.play("walk")
		print("Play Walk")
		
	if slide.y < 0:
		$AnimatedSprite.play("jump")
		print("Play Jump")
	if slide.y > 0:
		$AnimatedSprite.play("fall")
		print("Play Fall")

	if slide.x < 0:
		$AnimatedSprite.flip_h = true
	elif slide.x > 0:
		$AnimatedSprite.flip_h = false

func _shake_camera():
	$Camera2DWithShake.shake(0.4, 15, 8)
	emit_signal("stomped")
	
func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	var pound = Input.is_action_pressed("pound")
	var climb = Input.is_action_pressed("climb")
	
	velocity.x = 0
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed
	if jump && is_on_floor():
		velocity.y = -jump_speed
	if pound && not is_on_floor():
		velocity.y = 2000
		velocity.x = 0
		pounding = true
	if climb && is_on_ladder:
		velocity.y = -climb_speed


func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "walk":
		if $AnimatedSprite.frame == 0 || $AnimatedSprite.frame == 3:
			$RandomSoundPlayer.play()
