extends Sprite

var changing_currency : bool = false
var person_charging_currency : KinematicBody2D = null

func start_currency_change(person):
	person_charging_currency = person
	print("Start!")

func _on_collider_body_entered(body):
	if person_charging_currency == null:
		if body.decide_if_change_currency():
			start_currency_change(body)
