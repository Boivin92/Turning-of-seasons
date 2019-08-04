extends Control

export (PackedScene) var level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TweenFirst.interpolate_property($Label, "modulate", Color(1,1,1,0), Color(1,1,1,1), 5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenFirst.start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TweenFirst_tween_completed(object: Object, key: NodePath) -> void:
	$TweenSecond.interpolate_property($Label2, "modulate", Color(1,1,1,0), Color(1,1,1,1), 5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenSecond.start()


func _on_TweenSecond_tween_completed(object: Object, key: NodePath) -> void:
	$TweenFinal.interpolate_property($Label, "modulate", Color(1,1,1,1), Color(1,1,1,0), 5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenFinal.interpolate_property($Label2, "modulate", Color(1,1,1,1), Color(1,1,1,0), 5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$TweenFinal.start()


func _on_TweenFinal_tween_completed(object: Object, key: NodePath) -> void:
	get_tree().change_scene_to(level)
