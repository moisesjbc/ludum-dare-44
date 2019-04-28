extends Sprite

var person_charging_currency : KinematicBody2D = null
signal currency_change_started
var start_money : int = 500
var money : int = 500


func start_currency_change(person):
	person_charging_currency = person
	emit_signal("currency_change_started", person, self)


func _on_collider_body_entered(body):
	if person_charging_currency == null:
		if body.decide_if_change_currency():
			start_currency_change(body)
			

func _on_change_screen_currency_change_stopped(fight):
	if fight:
		# start(money, damage_per_hit, total_hits, time_between_hits):
		$fight_screen.start(self, randi() % 10 + 10, randi() % 5 + 2, 1.0)
	else:
		$collider/CollisionShape2D.disabled = false
		person_charging_currency.stop_currency_change()
		person_charging_currency = null


func _on_fight_screen_stopped():
	$collider/CollisionShape2D.disabled = false
	person_charging_currency.stop_currency_change()
	person_charging_currency = null
