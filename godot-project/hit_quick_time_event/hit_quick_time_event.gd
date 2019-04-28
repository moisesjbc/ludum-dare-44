extends Area2D

signal quick_time_event_failed
signal quick_time_event_succeeded

func _on_hit_quick_time_event_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		emit_signal('quick_time_event_succeeded')
		queue_free()

func _on_Timer_timeout():
	emit_signal('quick_time_event_failed')
	queue_free()


func _on_hit_quick_time_event_mouse_entered():
	pass # Replace with function body.
