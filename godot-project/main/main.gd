extends Node2D

export (NodePath) var currency_change_screen_path = null

func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		$pause_menu.pause_game()


func _on_change_machine_currency_change_started(person, change_machine):
	$gui.pause_timer()
	$change_screen.start(person, change_machine)


func _on_gui_time_finished():
	var current_money = $change_machine.money
	if $change_machine.person_charging_currency:
		 current_money -= $change_machine.person_charging_currency.money
	$change_screen.visible = false
	$game_over_menu.run(current_money - $change_machine.start_money)


func _on_change_machine_currency_change_finished():
	$gui.resume_timer()
