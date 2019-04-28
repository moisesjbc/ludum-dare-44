extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var direction = 1
export (float) var speed = 200.0
var walking : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if walking:
		var velocity : Vector2 = Vector2(0.0, 0.0)
		velocity.x = speed * direction * delta
		move_and_collide(velocity)


func _on_VisibilityEnabler2D_screen_exited():
	print("Delete person!")
	queue_free()
