extends Node2D

@export var scroll_speed := 500
var bg_height := 3000 #altura del fondo

#config piedras
@export var separacion_vertical := 100  # Espacio entre piedras (Y)
@export var margen_izquierdo := 0
@export var margen_derecho := 100
@export var margen_pared := 80        # Distancia desde los bordes (X)
var textura_piedra = preload("res://assets/piedras_borde.png")  # Asegúrate de que esta ruta es correcta
var ultima_pos_y := 0.0
var roca_prueba : Sprite2D  # Variable global para controlar la roca de prueba

func _ready() -> void:
	generar_paredes_iniciales()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += scroll_speed * delta
	
	$Sprite1.position.y += scroll_speed * delta
	$Sprite2.position.y += scroll_speed * delta
	#roca_prueba.position.y += scroll_speed * delta  # Movemos la roca
	
	# Reciclaje del fondo
	if $Sprite1.position.y > bg_height:
		$Sprite1.position.y = $Sprite2.position.y - bg_height
	if $Sprite2.position.y > bg_height:
		$Sprite2.position.y = $Sprite1.position.y - bg_height
	
func generar_paredes_iniciales():
	# Genera piedras iniciales para cubrir la pantalla
	for i in range(20):
		generar_paredes(i * separacion_vertical)

func generar_paredes(pos_y: float):
	# Pared izquierda (1 piedra)
	var piedra_izq = crear_piedra_individual()
	piedra_izq.position = Vector2(margen_izquierdo, pos_y)
	add_child(piedra_izq)
	
	# Pared derecha (1 piedra)
	var piedra_der = crear_piedra_individual()
	piedra_der.position = Vector2(get_viewport().size.x - margen_derecho, pos_y)
	add_child(piedra_der)
	
	ultima_pos_y = pos_y  # Actualiza la última posición generada

func crear_piedra_individual() -> Sprite2D:
	# Crea una nueva piedra con la textura y escala definidas
	var piedra = Sprite2D.new()
	piedra.texture = textura_piedra
	piedra.centered = false
	piedra.scale = Vector2(0.15, 0.15)  # Tamaño estándar para las paredes
	return piedra
