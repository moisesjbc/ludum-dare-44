extends Control

signal currency_change_stopped
var person = null
var change_machine = null
var fight : bool = false

func start(person, change_machine):
	self.person = person
	self.change_machine = change_machine
	self.fight = false
	
	$CenterContainer/Panel/CenterContainer/VBoxContainer/change_button.visible = true
	$CenterContainer/Panel/CenterContainer/VBoxContainer/reaction_label.visible = false
	$CenterContainer/Panel/CenterContainer/VBoxContainer/continue_button.visible = false
	
	$CenterContainer/Panel/CenterContainer/VBoxContainer/label.text = "X wants to cash a cheque for " + str(person.money) + " euros"
	
	# Set the maximum value
	$CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.max_value = person.money
	$CenterContainer/Panel/CenterContainer/VBoxContainer/HBoxContainer/max_money.text = str(person.money)
	$CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value = person.money
	
	self._on_HSlider_value_changed(person.money)
	visible = true


func stop():
	emit_signal("currency_change_stopped", self.fight)
	visible = false


func _on_change_button_pressed():
	change_machine.modify_money(person.money - int($CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value))
	print((int($CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value) - person.money))
	
	if $CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value < person.money:
		$CenterContainer/Panel/CenterContainer/VBoxContainer/change_button.visible = false
		$CenterContainer/Panel/CenterContainer/VBoxContainer/reaction_label.visible = true
		$CenterContainer/Panel/CenterContainer/VBoxContainer/reaction_label.text = "Your client..."
		$reaction_timer.start(1.0)
	else:
		stop()


func _on_reaction_timer_timeout():
	var pissed_off_meter : int = 100 - (($CenterContainer/Panel/CenterContainer/VBoxContainer/HSlider.value / person.money) * 100)
	
	var random = randi() % 100
	
	self.fight = (random <= pissed_off_meter)
	
	if self.fight:
		$grunt_sound.play(0.75)
		$CenterContainer/Panel/CenterContainer/VBoxContainer/reaction_label.text = "Your client... IS PISSED OFF!"
	else:
		$meh_sound.play(0.75)
		$CenterContainer/Panel/CenterContainer/VBoxContainer/reaction_label.text = "Your client doesn't mind!"
		
	$CenterContainer/Panel/CenterContainer/VBoxContainer/continue_button.visible = true


func _on_HSlider_value_changed(value):
	var return_text : String = "Return " + str(value) + " euros"
	var help_text : String = "You are returning all the money"
	if value > person.money:
		help_text = "You are giving " + str(value - person.money) + " euros away!"
	elif value < person.money:
		help_text = "You are stealing " + str(-(value - person.money)) + " euros from the client!"

	$CenterContainer/Panel/CenterContainer/VBoxContainer/result_label.text = return_text + " (" + help_text + ")"


func _on_continue_button_pressed():
	stop()
