extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var speed: float = 200.0
@onready var sprite = $AnimatedSprite2D
var health = 80
var max_health = 100
var vida = 100


func _physics_process(delta):

	#position.y += 50 * delta
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
	
	# Control de velocidad del scroll (independiente del movimiento)
	var background = get_parent().get_node("Background")  # Ajustá si es necesario

	if Input.is_action_pressed("move_up"):
		background.scroll_speed = 1500
	elif Input.is_action_pressed("move_down"):
		background.scroll_speed = 300
	else:
		background.scroll_speed = 500

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
		
func heal(amount: int):
	health = min(health + amount, max_health)
	print("Cura recibida! Vida actual:", health)
	
func take_damage(amount):
	vida -= amount
	print("Daño recibido. Vida actual: ", vida)

	if vida <= 0:
		print("GAME OVER")
