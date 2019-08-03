extends KinematicBody2D

var velocity : Vector2 = Vector2()
export (int) var gravity : int
export (int) var run_speed : int
export (int) var jump_speed : int

var pounding : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += gravity * delta
	if not pounding:
		get_input()
	velocity.y = clamp(velocity.y, -2000, 2000)
	var airborne = not is_on_floor()
	_set_sprite()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if airborne && is_on_floor():
		_shake_camera()
		
	if pounding && is_on_floor():
		pounding = false
		
		
func _set_sprite() -> void:
	if velocity.x < 0:
		$Sprite.flip_h = true
	elif velocity.x > 0:
		$Sprite.flip_h = false

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