extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var speed: float = 200.0
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction := Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	# Cambiar animación según dirección
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				sprite.animation = "right"
			else:
				sprite.animation = "left"
		else:
			if direction.y > 0:
				sprite.animation = "down"
			else:
				sprite.animation = "up"

		if not sprite.is_playing():
			sprite.play()
	else:
		sprite.stop()
