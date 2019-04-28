extends Control

signal currency_change_stopped

func start(input_money : int):
	visible = true
	
func stop():
	emit_signal("currency_change_stopped")
	visible = false


func _on_change_button_pressed():
	stop()
