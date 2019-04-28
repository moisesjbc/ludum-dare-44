extends Node2D

export (NodePath) var currency_change_screen_path = null

func _process(delta):
	if Input.is_action_pressed("ui_pause"):
		$pause_menu.pause_game()

func _on_change_machine_currency_change_started(person, change_machine):
	$change_screen.start(person, change_machine)
