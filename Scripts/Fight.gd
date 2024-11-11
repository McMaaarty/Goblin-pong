extends Sprite2D

@export var bonus_scene : PackedScene  # Assigne la scène du bonus via l'inspecteur
@onready var ball = $Ball  # Initialiser la référence à la balle
var score := [0, 0]  
const PADDLE_SPEED : int = 500

func _ready():
	EventBus.subscribe("bonus_removed", Callable(self, "restartTimer"))

func restartTimer():
	$BonusTimer.start()

func _on_ball_timer_timeout():
	$Ball.new_ball()

func _on_score_left_body_entered(body):
	GameManager.score_left += 1
	$Hub/PlayerScore.text = str(GameManager.score_left)
	update_score(body)

func _on_score_right_body_entered(body):
	GameManager.score_right += 1
	$Hub/CpuScore.text = str(GameManager.score_right)
	update_score(body)

func update_score(body):	
	$Camera2D.apply_shake()

	if GameManager.score_left >= 10 or GameManager.score_right >= 10:
		get_tree().change_scene_to_file("res://Scenes/EndScreen.tscn")
	elif body.is_in_group("Ball") :
		
		if body.init_ball == true :
			body.speed = 0
		else :
			body.destroy()
	
	if get_tree().get_nodes_in_group("Ball").size() == 1 :
		$BallTimer.start()

func _on_bonus_timer_timeout():
	var bonus = bonus_scene.instantiate()
	bonus.position = Vector2(randf_range(200, 600), randf_range(100, 400))
	add_child(bonus)
