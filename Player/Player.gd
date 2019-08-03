extends KinematicBody2D

var velocity : Vector2 = Vector2()
export (int) var gravity
export (int) var run_speed
export (int) var jump_speed

var pounding : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.y += gravity * delta
	if not pounding:
		get_input()
	velocity.y = clamp(velocity.y, -2000, 2000)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	if pounding && is_on_floor():
		pounding = false
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
	if jump:
		velocity.y = -jump_speed
	if pound:
		velocity.y = 2000
		velocity.x = 0
		pounding = true