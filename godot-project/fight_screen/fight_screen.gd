extends Node2D

export (PackedScene) var quick_time_event_template = null
var total_hits : int = 4
var hit_time : float = 1
var time_between_hits : float = 1
var damage_per_hit : int = 20
var money : int
var change_machine = null

signal stopped

func start(change_machine, damage_per_hit, total_hits, time_between_hits):
	visible = true
	self.change_machine = change_machine
	self.money = change_machine.money
	self.damage_per_hit = damage_per_hit
	self.total_hits = total_hits
	self.time_between_hits = time_between_hits
	$start_timer.start(1.0)
	
func stop():
	emit_signal("stopped")
	print("stopped")

func _on_start_timer_timeout():
	var quick_time_event = quick_time_event_template.instance()
	quick_time_event.position.x = randi() % int($bottom_right_corner.position.x - $upper_left_corner.position.x) + $upper_left_corner.position.x
	quick_time_event.position.y = randi() % int($bottom_right_corner.position.y - $upper_left_corner.position.y) + $upper_left_corner.position.y
	add_child(quick_time_event)
	
	quick_time_event.connect("quick_time_event_failed", self, "_on_quick_time_event_failed")
	quick_time_event.connect("quick_time_event_succeeded", self, "_on_quick_time_event_succeeded")

func finish_hit():
	total_hits -= 1
	print('total_hits')
	print(total_hits)
	if total_hits > 0:
		$start_timer.start(self.time_between_hits)
	else:
		stop()

func _on_quick_time_event_failed():
	finish_hit()
	
func _on_quick_time_event_succeeded():
	finish_hit()