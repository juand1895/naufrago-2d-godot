extends CanvasLayer

@onready var barra_vida = $BarraVida
@onready var texto_puntos = $TextoPuntos

func _ready():
	print("🔍 HUD iniciado")
	
	# CONECTAR SEÑALES
	GameManager.vida_actualizada.connect(actualizar_barra_vida)
	GameManager.puntos_actualizados.connect(actualizar_contador_puntos)
	
	# INICIALIZAR
	actualizar_barra_vida(GameManager.vida_actual)
	actualizar_contador_puntos(GameManager.puntuacion)

func actualizar_barra_vida(nueva_vida: int):
	if barra_vida:
		barra_vida.value = nueva_vida
		
		# CAMBIAR COLOR
		if nueva_vida > 70:
			_set_bar_color(Color.GREEN)
		elif nueva_vida > 30:
			_set_bar_color(Color.YELLOW)
		else:
			_set_bar_color(Color.RED)

func _set_bar_color(color: Color):
	var fill_style = barra_vida.get_theme_stylebox("fill")
	if fill_style:
		fill_style.bg_color = color

func actualizar_contador_puntos(nuevos_puntos: int):
	if texto_puntos:
		# 🆕 LÍNEA CORREGIDA - Usar obtener_mejor_record()
		var mejor_record = GameManager.obtener_mejor_record()
		texto_puntos.text = "Puntos: %d\nRecord: %s - %d" % [nuevos_puntos, mejor_record["iniciales"], mejor_record["puntuacion"]]
