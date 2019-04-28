extends Control

export (int) var seconds_remaining = 10
signal time_finished

func _ready():
	update_time(seconds_remaining)


func update_time(seconds_remaining):
	var minutes = seconds_remaining / 60
	var seconds = seconds_remaining % 60
	$CenterContainer/VBoxContainer/timer_label.text = str(minutes) + ":" + str("%02d" % seconds)

func update_money(money):
	$CenterContainer/VBoxContainer/money_label.text = str("%010d" % money)

func _on_timer_timeout():
	seconds_remaining -= 1
	update_time(seconds_remaining)
	if seconds_remaining == 0:
		emit_signal("time_finished")
