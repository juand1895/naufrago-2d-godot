extends Area2D

@export var velocidad_caida: float = 100.0  # Velocidad hacia abajo
@export var tiempo_para_aparecer: float = 30.0  # 30 segundos
@export var escala_barco: float = 0.3  # Tamaño más pequeño

var aparecido: bool = false

func _ready():
	# 🎯 POSICIÓN INICIAL - ARRIBA de la pantalla, CENTRADO en X
	# Para portrait 648x1152:
	position = Vector2(324, -100)  # X: centro (648/2=324), Y: arriba (-100)
	
	# 🎯 CONFIGURAR ESCALA más pequeña
	$Sprite2D.scale = Vector2(escala_barco, escala_barco)
	
	# 🎯 INICIALMENTE invisible
	visible = false
	
	# 🔗 CONECTAR señales
	#body_entered.connect(_on_body_entered)
	
	# 🕐 CONFIGURAR Timer
	$Timer.wait_time = tiempo_para_aparecer
	$Timer.autostart = true
	#$Timer.timeout.connect(_on_timer_timeout)
	
	print("🚢 Barco listo - Caerá desde arriba en ", tiempo_para_aparecer, " segundos")

func _physics_process(delta):
	if aparecido:
		# 🎯 MOVER barco hacia ABAJO (como los objetos)
		position.y += velocidad_caida * delta
		print("🚢 Barco cayendo - Y:", position.y)  # ← DEBUG
		
		# 🗑️ ELIMINAR si sale por abajo (por si no lo atrapan)
		if position.y > 1300:
			queue_free()

func _on_body_entered(body):
	# 🎯 DETECTAR colisión con JUGADOR
	if body.is_in_group("jugador") and aparecido:
		print("🎉 ¡Jugador rescatado! Puntos: ", GameManager.puntuacion)
		GameManager.terminar_juego(true)
		call_deferred("_cambiar_a_victoria")

func _cambiar_a_victoria():
	if is_inside_tree():
		get_tree().change_scene_to_file("res://victory/Victory.tscn")
		
func aparecer():
	# 🎪 HACER visible y activar caída
	if not aparecido:
		aparecido = true
		visible = true
		set_physics_process(true)  # ← ACTIVAR caída
		print("🚢 ¡BARCO CAYENDO DESDE ARRIBA!")

func _on_timer_timeout():
	# ⏰ LLAMADO cuando el Timer termina
	print("⏰ TIMER TERMINADO - Barco cayendo...")
	if not aparecido:
		aparecer()
