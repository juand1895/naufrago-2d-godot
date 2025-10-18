extends Node

# 🔔 SEÑALES
signal vida_actualizada(vida_actual)
signal puntos_actualizados(nuevos_puntos)
signal juego_terminado(puntuacion_final, victoria)
signal nuevo_record_alcanzado(puntuacion_record)

# 🎯 VARIABLES
var puntuacion: int = 0
var vida_actual: int = 100
var records: Array = []

# 🔗 REFERENCIA al barco
#var barco_rescate: Node = null

# 📁 ARCHIVOS
const ARCHIVO_RECORDS = "user://records.json"
const ARCHIVO_ULTIMA_PARTIDA = "user://ultima_partida.json"

func _ready():
	# 📁 CREAR carpeta data si no existe
#	crear_carpeta_data()
	# 📂 CARGAR records existentes
	cargar_records()
	
	print("🎮 GameManager listo")
	print("📊 Records cargados: ", records.size())
	if records.size() > 0:
		print("🥇 Mejor record: ", records[0]["iniciales"], " - ", records[0]["puntuacion"])


#func crear_carpeta_data():
#	"""📁 Crea la carpeta data si no existe"""
#	var directorio = DirAccess.open("res://")
#	if directorio and not directorio.dir_exists("data"):
#		directorio.make_dir("data")
#		print("✅ Carpeta 'data' creada")
func reiniciar_y_jugar():
	"""🔁 Reinicia el juego y borra la partida anterior"""
	reiniciar_juego()
	# Borrar archivo de última partida para empezar desde cero
	if FileAccess.file_exists(ARCHIVO_ULTIMA_PARTIDA):
		DirAccess.remove_absolute(ARCHIVO_ULTIMA_PARTIDA)
	get_tree().change_scene_to_file("res://scenes/Juego.tscn")

func reiniciar_juego():
	"""🔄 Restablece todos los valores"""
	puntuacion = 0
	vida_actual = 100
	vida_actualizada.emit(vida_actual)
	puntos_actualizados.emit(puntuacion)
	print("🔄 Juego reiniciado")

func agregar_puntos(cantidad: int):
	"""💰 Suma puntos"""
	puntuacion += cantidad
	puntos_actualizados.emit(puntuacion)
	print("💰 +", cantidad, " puntos - Total: ", puntuacion)

func cambiar_vida(cantidad: int):
	"""❤️ Modifica la vida"""
	vida_actual += cantidad
	vida_actual = clamp(vida_actual, 0, 100)
	vida_actualizada.emit(vida_actual)
	print("❤️ ", cantidad, " vida - Actual: ", vida_actual, "/100")
	
	if vida_actual <= 0:
		terminar_juego(false)

func terminar_juego(victoria: bool):
	"""🎯 Termina el juego"""
	if victoria:
		print("🎉 ¡VICTORIA! Puntos: ", puntuacion)
		verificar_y_guardar_record(puntuacion)
	else:
		print("💀 ¡DERROTA! Puntos: ", puntuacion)
		guardar_puntuacion_actual(puntuacion)
		get_tree().change_scene_to_file("res://defeat/Defeat.tscn") # ← escena de derrota
	
	juego_terminado.emit(puntuacion, victoria)

func verificar_y_guardar_record(nueva_puntuacion: int):
	"""🏆 VERIFICAR record y ACTUALIZAR si es mejor"""
	print("🏆 ===== VERIFICANDO RECORD =====")
	print("📊 Puntuación actual: ", nueva_puntuacion)
	
	if records.size() > 0:
		print("🥇 Record actual: ", records[0]["iniciales"], " - ", records[0]["puntuacion"])
	else:
		print("📭 No hay records guardados")
	
	# 💾 GUARDAR siempre la puntuación actual
	guardar_puntuacion_actual(nueva_puntuacion)
	
	# 📝 CREAR PRIMER RECORD si no hay records
	if records.size() == 0:
		print("📝 Creando primer record...")
		var primer_record = {
			"iniciales": "JUG",
			"puntuacion": nueva_puntuacion,
			"fecha": Time.get_datetime_string_from_system()
		}
		records = [primer_record]
		guardar_records()
		print("✅ Primer record creado: JUG - ", nueva_puntuacion)
		nuevo_record_alcanzado.emit(nueva_puntuacion)
	
	# 📈 ACTUALIZAR RECORD si es MEJOR
	elif nueva_puntuacion > records[0]["puntuacion"]:
		print("🎉 ¡NUEVO RECORD ALCANZADO!")
		print("   Viejo: ", records[0]["iniciales"], " - ", records[0]["puntuacion"])
		print("   Nuevo: JUG - ", nueva_puntuacion)
		
		var nuevo_record = {
			"iniciales": "JUG",
			"puntuacion": nueva_puntuacion,
			"fecha": Time.get_datetime_string_from_system()
		}
		
		# REEMPLAZAR el mejor record
		records[0] = nuevo_record
		guardar_records()
		
		print("✅ Record actualizado en archivo")
		nuevo_record_alcanzado.emit(nueva_puntuacion)
	
	else:
		print("📊 Buena puntuación, pero no supera el record")
	
	print("🏆 ===== VERIFICACIÓN COMPLETADA =====")

func guardar_puntuacion_actual(puntuacion_actual: int):
	"""💾 Guarda la puntuación de la partida actual"""
	var datos = {
		"puntuacion_actual": puntuacion_actual,
		"fecha": Time.get_datetime_string_from_system()
	}
	
	var archivo = FileAccess.open(ARCHIVO_ULTIMA_PARTIDA, FileAccess.WRITE)
	if archivo:
		archivo.store_string(JSON.stringify(datos))
		archivo.close()
		print("💾 Puntuación guardada: ", puntuacion_actual)

func guardar_record_completo(iniciales: String, puntuacion: int):
	"""🏆 Guarda nuevo record con iniciales"""
	print("🏆 Guardando record completo: ", iniciales, " - ", puntuacion)
	
	var nuevo_record = {
		"iniciales": iniciales,
		"puntuacion": puntuacion,
		"fecha": Time.get_datetime_string_from_system()
	}
	
	# 📥 AGREGAR nuevo record
	records.append(nuevo_record)
	
	# 📊 ORDENAR de mayor a menor
	records.sort_custom(func(a, b): return a["puntuacion"] > b["puntuacion"])
	
	# 🗑️ MANTENER top 5
	if records.size() > 5:
		records.resize(5)
		print("📊 Se eliminaron records antiguos (solo top 5)")
	
	# 💾 GUARDAR
	guardar_records()
	print("✅ Record guardado: ", iniciales, " - ", puntuacion)

func cargar_records():
	"""📂 Carga records desde archivo"""
	if FileAccess.file_exists(ARCHIVO_RECORDS):
		var archivo = FileAccess.open(ARCHIVO_RECORDS, FileAccess.READ)
		if archivo:
			var contenido = archivo.get_as_text()
			var datos = JSON.parse_string(contenido)
			
			if datos and datos.has("records"):
				records = datos["records"]
				print("📂 Records cargados: ", records.size())
			archivo.close()
	else:
		print("📂 No hay records guardados, empezando nuevo")
		records = []

func guardar_records():
	"""💾 Guarda todos los records"""
	var datos = { "records": records }
	
	var archivo = FileAccess.open(ARCHIVO_RECORDS, FileAccess.WRITE)
	if archivo:
		archivo.store_string(JSON.stringify(datos))
		archivo.close()
		print("💾 Records guardados: ", records.size())

# 🎯 FUNCIONES para pantallas
func obtener_ultima_puntuacion() -> int:
	"""📊 Obtiene puntuación de última partida"""
	if FileAccess.file_exists(ARCHIVO_ULTIMA_PARTIDA):
		var archivo = FileAccess.open(ARCHIVO_ULTIMA_PARTIDA, FileAccess.READ)
		if archivo:
			var contenido = archivo.get_as_text()
			var datos = JSON.parse_string(contenido)
			archivo.close()
			if datos and datos.has("puntuacion_actual"):
				return datos["puntuacion_actual"]
	return 0

func obtener_mejor_record() -> Dictionary:
	"""🥇 Obtiene el mejor record"""
	if records.size() > 0:
		return records[0]
	return {"iniciales": "---", "puntuacion": 0, "fecha": ""}

func obtener_todos_records() -> Array:
	"""📈 Obtiene todos los records"""
	return records
