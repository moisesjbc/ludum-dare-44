extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (bool) var destroy_people_moving_left = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_people_destroy_area_body_entered(body):
	if (destroy_people_moving_left and body.direction < 0) or \
		(not destroy_people_moving_left and body.direction > 0):
		body.destroy()
