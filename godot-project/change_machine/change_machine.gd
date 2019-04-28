extends Sprite

var person_charging_currency : KinematicBody2D = null
signal currency_change_started
signal currency_change_finished
signal money_changed
var start_money : int = 500
var money : int = 500

func _ready():
	emit_signal("money_changed", money)

func start_currency_change(person):
	person_charging_currency = person
	emit_signal("currency_change_started", person, self)


func _on_collider_body_entered(body):
	if person_charging_currency == null:
		if body.decide_if_change_currency():
			start_currency_change(body)


func modify_money(delta_money : int):
	money += delta_money
	if money < 0:
		money = 0
	emit_signal("money_changed", money)
	


func _on_change_screen_currency_change_stopped(fight):
	if fight:
		# start(money, damage_per_hit, total_hits, time_between_hits):
		$fight_screen.start(self, randi() % 10 + 10, randi() % 5 + 2, 1.0)
	else:
		$collider/CollisionShape2D.disabled = false
		person_charging_currency.stop_currency_change()
		person_charging_currency = null
		emit_signal('currency_change_finished')


func _on_fight_screen_stopped():
	$collider/CollisionShape2D.disabled = false
	person_charging_currency.stop_currency_change()
	person_charging_currency = null
	emit_signal('currency_change_finished')


func _on_fight_screen_hit_received(money_lost : int):
	modify_money(-money_lost)
