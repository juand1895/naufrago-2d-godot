extends Control

@onready var volumen_slider = $OptionsPanel/HSlider
@onready var musica_checkbox = $OptionsPanel/CheckBox
@onready var cerrar = $OptionsPanel/Cerrar
@onready var opciones_panel = $OptionsPanel
@onready var musica = $Musica
# Conectamos los botones al inicio
func _ready():
#	$ButtonContainer/Play.pressed.connect(_on_play_pressed)
#	$ButtonContainer/Options.pressed.connect(_on_options_pressed)
#	$ButtonContainer/Exit.pressed.connect(_on_exit_pressed)
#	$ButtonContainer/Story.pressed.connect(_on_story_pressed)
	volumen_slider.value_changed.connect(Callable(self, "_on_volumen_changed"))
	musica_checkbox.toggled.connect(Callable(self, "_on_musica_toggled"))
	cerrar.pressed.connect(Callable(self, "_on_cerrar_opciones"))
	
	mover_nube(Vector2(-200, 100), Vector2(900, 100), 10)
	mover_nube(Vector2(-300, 200), Vector2(900, 200), 15)
	mover_nube(Vector2(-400, 150), Vector2(900, 150), 20)
	# Función para mover la nube en loop infinito
func mover_nube(start: Vector2, end: Vector2, duration: float):
	var nube = $Cloud.duplicate() as Sprite2D
	add_child(nube)
	nube.position = start
	
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(nube, "position", end, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(nube, "position", start, duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/Juego.tscn") # Cambiá por tu escena de juego

func _on_options_pressed():
	print("Opciones presionado")
	opciones_panel.visible = true  # Muestra el panel de opciones

func _on_exit_pressed():
	get_tree().quit()
	
func _on_story_pressed():
	get_tree().change_scene_to_file("res://story/Story.tscn")
	
func _on_volumen_changed(value):
	# Cambia el volumen de la música (suponiendo que tu AudioStreamPlayer se llama "Musica")
	$Musica.volume_db = linear_to_db(value)
#func _on_musica_toggled(pressed):
#	$Musica.playing = pressed
	
func _on_musica_toggled(pressed: bool):
	if musica:
		musica.playing = pressed
		
func _on_cerrar_opciones():
	print("Cerrar presionado")  # para debug
	opciones_panel.visible = false


func _on_records_pressed() -> void:
	pass # Replace with function body.
