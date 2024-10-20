extends Sprite2D

@export var bonus_scene : PackedScene  # Assigne la scène du bonus via l'inspecteur
@onready var ball = $Ball  # Initialiser la référence à la balle
var score := [0, 0]  
const PADDLE_SPEED : int = 500

func _ready():
	$BonusTimer.start()  # Lance le timer pour la génération des bonus

func _on_ball_timer_timeout():
	$Ball.new_ball()

func _on_score_left_body_entered(body):
	GameManager.score_left += 1
	$Hub/PlayerScore.text = str(GameManager.score_left)
	update_score()
	
func _on_score_right_body_entered(body):
	GameManager.score_right += 1
	$Hub/CpuScore.text = str(GameManager.score_right)
	update_score()

func update_score():	
	$Camera2D.apply_shake()

	if GameManager.score_left >= 10 or GameManager.score_right >= 10:
		get_tree().change_scene_to_file("res://Scenes/EndScreen.tscn")
	else:
		$BallTimer.start()

func _on_bonus_timer_timeout():
	var bonus = bonus_scene.instantiate()
	bonus.position = Vector2(randf_range(200, 600), randf_range(100, 400))
	add_child(bonus)
