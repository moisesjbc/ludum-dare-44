extends KinematicBody2D

export (int) var direction = 1
export (float) var speed = 200.0
var walking : bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if walking:
		var velocity : Vector2 = Vector2(0.0, 0.0)
		velocity.x = speed * direction * delta
		move_and_collide(velocity)


func _on_VisibilityEnabler2D_screen_exited():
	print("Delete person!")
	queue_free()


func decide_if_change_currency():
	print("Gonna change")
	walking = false
	return true