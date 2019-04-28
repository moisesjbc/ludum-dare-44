extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var person_template

func _on_respawn_timer_timeout():
	var random = randi() % 100
	var person = person_template.instance()
	if random > 50:
		person.position = $left_respawn_point.position
		person.direction = 1
	else:
		person.position = $right_respawn_point.position
		person.direction = -1
		
	get_tree().get_root().add_child(person)
