extends KinematicBody2D

export (int) var direction = 1
export (float) var speed = 200.0
var walking : bool = true

export (int) var max_money = 200
export (int) var min_money = 50
var money : int = 0


func _ready():
	randomize()
	money = (randi() % (max_money - min_money)) + min_money

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if walking:
		var velocity : Vector2 = Vector2(0.0, 0.0)
		velocity.x = speed * direction * delta
		move_and_collide(velocity)


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()


func decide_if_change_currency():
	walking = false
	return true

func stop_currency_change():
	walking = true
	
	# Prevent this person from changing again
	$CollisionShape2D.disabled = true
	
func destroy():
	queue_free()