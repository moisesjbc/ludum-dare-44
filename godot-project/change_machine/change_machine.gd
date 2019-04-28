extends Sprite

var person_charging_currency : KinematicBody2D = null
signal currency_change_started

func start_currency_change(person):
	person_charging_currency = person
	emit_signal("currency_change_started", 100)

func _on_collider_body_entered(body):
	if person_charging_currency == null:
		if body.decide_if_change_currency():
			start_currency_change(body)


func _on_change_screen_currency_change_stopped():
	person_charging_currency.stop_currency_change()
	person_charging_currency = null
