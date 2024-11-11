extends Node2D

@export var ball_scene : PackedScene

func _on_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		apply_bonus("multi_ball");
	EventBus.emit_event("bonus_removed")
	queue_free()
	pass # Replace with function body.

# Appliquer le bonus lorsque la balle le touche
func apply_bonus(bonus_type: String):
	match bonus_type:
		"multi_ball":
			spawn_multiple_balls()

# Gestion du bonus "multi_ball"
func spawn_multiple_balls():
	for angle in [-PI / 8, PI / 8]:
		var new_ball = ball_scene.instantiate()
		new_ball.position = position
		new_ball.init_ball = false
		get_parent().call_deferred("add_child", new_ball)
