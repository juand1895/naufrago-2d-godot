extends CharacterBody2D

@export var velocidad: float = 300.0
@onready var sprite = $Sprite2D

func _ready():
	# AGREGAR AL GRUPO PARA DETECCIÓN DE COLISIONES
	add_to_group("jugador")
	print("✅ Jugador listo - Grupo 'jugador' asignado")

func _physics_process(delta):
	# USAR LAS ACCIONES CORRECTAS del Input Map
	var direccion = Input.get_axis("ui_left", "ui_right")

	velocity.x = direccion * velocidad
	velocity.y = 0

	# Cambiar sprite según dirección
	if direccion > 0:
		sprite.texture = preload("res://assets/right.png")
	elif direccion < 0:
		sprite.texture = preload("res://assets/left.png")

	move_and_slide()
