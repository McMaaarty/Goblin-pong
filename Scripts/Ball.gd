extends CharacterBody2D

var win_size : Vector2
const START_SPEED : int = 500
const ACCEL : int = 50
var speed : int
var dir : Vector2
const MAX_Y_VECTOR : float = 0.6
var last_player  # Garder une trace du dernier joueur ayant touché la balle

# Called when the node enters the scene tree for the first time.
func _ready():
	win_size = get_viewport_rect().size
	new_ball()

func new_ball():
	$Trail2D.clear_points()
	#randomize start position and direction
	position = Vector2(win_size.x / 2, randi_range(200, win_size.y - 200))
	speed = START_SPEED
	dir = random_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		 # Si la balle touche une palette
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCEL
			dir = new_direction(collider)
		# Si la balle touche un mur
		else:
			dir = dir.bounce(collision.get_normal())

func random_direction():
	var new_dir := Vector2([1, -1].pick_random(), randf_range(-MAX_Y_VECTOR, MAX_Y_VECTOR))
	return new_dir.normalized()

func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	# Inverse la direction horizontale
	new_dir.x = -dir.x
	# Calcule une nouvelle direction verticale basée sur la position de la balle sur la palette
	new_dir.y = (dist / (collider.p_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
	
# Appliquer le bonus lorsque la balle le touche
func apply_bonus(bonus_type: String):
	match bonus_type:
		"multi_ball":
			spawn_multiple_balls()

# Gestion du bonus "multi_ball"
func spawn_multiple_balls():
	for angle in [-PI / 8, PI / 8]:
		var new_ball = self.duplicate()
		new_ball.dir = dir.rotated(angle)
		get_parent().add_child(new_ball)
