extends Sprite

func _on_collider_body_entered(body):
	body.decide_if_change_currency()
