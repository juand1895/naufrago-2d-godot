extends Node2D

# Export variables para poder ajustar desde el Inspector
@export var objeto_caida: PackedScene = preload("res://scenes/objeto_caida.tscn")
@export var tiempo_entre_spawn: float = 1.5  # Segundos entre spawns

var temporizador: float = 0.0

# CONSTANTES PARA PORTRAIT (648x1152)
# Estos valores deben ajustarse según la posición REAL de tus rocas
const ROCA_IZQ_X = 150    # Posición X de la roca izquierda
const ROCA_DER_X = 500    # Posición X de la roca derecha  
const MARGEN_SEGURO = 40  # Margen para no spawnear muy cerca de las rocas

func _process(delta):
	# Temporizador para generar objetos cada X segundos
	temporizador += delta
	if temporizador >= tiempo_entre_spawn:
		temporizador = 0.0
		_spawn_objeto()

func _spawn_objeto():
	# Instanciar el objeto
	var obj = objeto_caida.instantiate()
	
	# Asignar tipo aleatorio (moneda, vida o daño)
	var tipos = ["moneda", "vida", "dano"]
	obj.tipo_objeto = tipos[randi() % tipos.size()]
	
	# CALCULAR POSICIÓN dentro del pasillo
	# x_min: posición roca izquierda + margen de seguridad
	var x_min = ROCA_IZQ_X + MARGEN_SEGURO
	# x_max: posición roca derecha - margen de seguridad  
	var x_max = ROCA_DER_X - MARGEN_SEGURO
	
	# Posicionar el objeto (arriba de la pantalla en Y negativo)
	obj.global_position = Vector2(randf_range(x_min, x_max), -50)
	
	# Agregar a la escena
	get_parent().add_child(obj)
	print("Objeto generado en X: ", obj.global_position.x)
