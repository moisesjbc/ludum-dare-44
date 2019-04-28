extends CenterContainer


func _ready():
	visible = false


func run(score):
	$panel/margin/layout/score.text = "Score (money earned): " + str(score) + " euros"
	get_tree().call_group("people", "destroy")
	pause_game()

func pause_game():
	print("pause_game")
	get_tree().paused = true
	visible = true

func unpause_game():
	print("unpause_game")
	get_tree().paused = false
	visible = false

func _on_return_button_pressed():
	unpause_game()
	print('Changing scene!')
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")

func _on_restart_button_pressed():
	unpause_game()
	get_tree().change_scene("res://main/main.tscn")
