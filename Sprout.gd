extends Area2D

export (Texture) var sprout_fall
export (Texture) var sprout_winter
export (Texture) var sprout_summer
export (Texture) var sprout_spring

export (Texture) var middle_A
export (Texture) var middle_B
export (Texture) var top_A
export (Texture) var top_B

export (int) var height

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if height > 1:
		$CollisionShape2D.position.y = -height * 48
		$CollisionShape2D.shape.extents.y = height * 64
		for i in height:
			var y = i+1
			if y == height: 
				if y % 2 == 0:
					var spr = Sprite.new()
					spr.texture = top_B
					spr.position.y = -128 * (y-1)
					$ExtentionsContainer.add_child(spr)
				else:
					var spr = Sprite.new()
					spr.texture = top_A
					spr.position.y = -128 * (y-1)
					$ExtentionsContainer.add_child(spr)
			elif y % 2 == 0:
				var spr = Sprite.new()
				spr.texture = middle_B
				spr.position.y = -128 * (y-1)
				$ExtentionsContainer.add_child(spr)
			else:
				var spr = Sprite.new()
				spr.texture = middle_A
				spr.position.y = -128 * (y-1)
				$ExtentionsContainer.add_child(spr)
	Summer()
	
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_6):
		Spring()
	if Input.is_key_pressed(KEY_7):
		Summer()
	if Input.is_key_pressed(KEY_8):
		Fall()
	if Input.is_key_pressed(KEY_9):
		Winter()

func Spring():
	$CollisionShape2D.disabled = true
	$SproutSprite.texture = sprout_spring
	$SproutSprite.visible = true
	_show_vines(false)
	
func Summer():
	$CollisionShape2D.disabled = false
	$SproutSprite.texture = sprout_summer
	$SproutSprite.visible = false
	_show_vines(true)
	
func Fall():
	$CollisionShape2D.disabled = true
	$SproutSprite.texture = sprout_fall
	$SproutSprite.visible = true
	_show_vines(false)
	
func Winter():
	$CollisionShape2D.disabled = true
	$SproutSprite.texture = sprout_winter
	$SproutSprite.visible = true
	_show_vines(false)
	
func _show_vines(state : bool):
	for sprite in $ExtentionsContainer.get_children():
		sprite.visible = state

func _on_Sprout_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		body.is_on_ladder = true


func _on_Sprout_body_exited(body: PhysicsBody2D) -> void:
	if body.is_in_group("player"):
		body.is_on_ladder = false
