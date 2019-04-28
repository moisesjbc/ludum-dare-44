extends Control

signal currency_change_stopped
var person = null
var change_machine = null

func start(person, change_machine):
	self.person = person
	self.change_machine = change_machine
	self.change_machine.money += person.money
	
	$CenterContainer/Panel/CenterContainer/VBoxContainer/label.text = "X wants to change " + str(person.money) + " €"
	
	if change_machine.money > person.money:
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.max_value = change_machine.money
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value = person.money

		#$CenterContainer/Panel/CenterContainer/VBoxContainer/HBoxContainer/input_money.text = str(person.money)
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HBoxContainer/max_money.text = str(change_machine.money)
	else:
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.max_value = change_machine.money
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value = change_machine.money
		
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HBoxContainer/input_money.text = ""
		$CenterContainer/Panel/CenterContainer/VBoxContainer/HBoxContainer/max_money.text = str(change_machine.money)
	
	self._on_HSlider_value_changed($CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value)
	visible = true


func stop():
	emit_signal("currency_change_stopped")
	change_machine.money -= int($CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value)
	visible = false


func _on_change_button_pressed():
	stop()


func _on_HSlider_value_changed(value):
	var return_text : String = "Return " + str(value) + " euros"
	var help_text : String = "You are returning all the money"
	if value > person.money:
		help_text = "You are giving " + str(value - person.money) + " euros away!"
	elif value < person.money:
		help_text = "You are stealing " + str(-(value - person.money)) + " euros from the client!"

	$CenterContainer/Panel/CenterContainer/VBoxContainer/result_label.text = return_text + " (" + help_text + ")"
