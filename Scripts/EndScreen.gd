extends Control

func _ready():
	if GameManager.score_left > GameManager.score_right:
		$Label.text = "Joueur 1 Gagne!"
	else:
		$Label.text = "Joueur 2 Gagne!"
