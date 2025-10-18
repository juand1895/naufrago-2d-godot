extends Control

@export var archivo_records := "user://records.json"
@export var archivo_ultima := "user://ultima_partida.json"

@onready var popup_ui = $Popup
@onready var lineedit = $Popup/VBoxContainer/HBoxContainer/LineEdit
@onready var vbox_scores = $Popup/VBoxContainer/VBoxContainer  # Top 5 puntajes

var puntaje_actual: int = 12345  # reemplazá con el puntaje real de la partida

func _ready():
	# Mostrar el popup centrado al inicio
	popup_ui.popup_centered()


func _on_reset_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/Juego.tscn")
	GameManager.reiniciar_y_jugar()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/Menu.tscn")


func _on_guardar_pressed() -> void:
	var iniciales = lineedit.text.strip_edges().to_upper()
	if iniciales.length() != 3:
		print("Por favor, ingresa 3 letras")
		return

	# Desactivar input después de guardar
	lineedit.editable = false
	$Popup/VBoxContainer/HBoxContainer/Guardar.disabled = true
