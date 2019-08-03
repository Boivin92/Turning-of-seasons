extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_next_rotation()
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		$Tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	set_next_rotation()

func set_next_rotation():
	$Tween.remove_all()
	$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, rotation_degrees + 90, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)