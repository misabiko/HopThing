extends Label

onready var tween = $Tween
onready var timer = $Timer
onready var upper_rect = $".."/UpperRect
onready var lower_rect = $".."/LowerRect

func game_over():
	visible = true
	if get_viewport() != null:
		margin_left = get_viewport().size.x * 2 + rect_size.x + 100
	
	tween.interpolate_property(self, "margin_left", margin_left, 0, 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.5)
	tween.interpolate_property($".."/UpperRect, "margin_bottom", 0, 375, 1.25, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.5)
	tween.interpolate_property($".."/LowerRect, "margin_top", 0, -375, 1.25, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.5)
	tween.start()
	timer.start()

func _on_Timer_timeout():
	get_tree().reload_current_scene()
