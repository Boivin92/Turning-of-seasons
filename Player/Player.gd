extends KinematicBody2D

var velocity : Vector2 = Vector2()
export (int) var gravity : int
export (int) var run_speed : int
export (int) var jump_speed : int

var pounding : bool
var available : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func brace_character():
	available = false
	$AnimatedSprite.play("brace")
	
func release_bracing():
	available = true

func _physics_process(delta):
	if is_on_floor():
		velocity.y = 0
	velocity.y += gravity * delta
	if not pounding && available:
		get_input()
	velocity.y = clamp(velocity.y, -2000, 2000)
	var airborne = not is_on_floor()
	
	move_and_slide(velocity, Vector2(0, -1), false, 4, 0.523599)
	_set_sprite()
	if airborne && is_on_floor():
		_shake_camera()
		
	if pounding && is_on_floor():
		pounding = false
		
		
func _set_sprite() -> void:
	if available:
		if velocity.x == 0:
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")
	else:
		#TODO: play bracing animation
		pass
		
	if velocity.y < 0:
		$AnimatedSprite.play("jump")
	if velocity.y > 0:
		$AnimatedSprite.play("fall")
		
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false

func _shake_camera():
	$Camera2DWithShake.shake(0.4, 15, 8)
	
func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	var pound = Input.is_action_pressed("pound")
	
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
