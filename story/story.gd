extends Control

@onready var story_label := $CenterContainer/StoryLabel
@onready var siguiente := $TextureRect/HBoxContainer/Siguiente
@onready var omitir := $TextureRect/HBoxContainer/Omitir
@onready var typing_timer := $TypingTimer 
@onready var typing_sound := $TypingSound 
@onready var background_music := $Background_music 

var lines := [
	"Era un día sin calma. El mar rugía y el viento 
	cortaba como cuchillas.",
	"La tormenta fue violenta y, cuando despertaste, 
	estabas flotando entre los restos del barco.
	No ves tierra a tu alrededor, solo agua y cielo.",
	"El sol quema y las olas golpean sin piedad. 
	Deberás usar los restos del barco 
	para construir algo que te ayude a sobrevivir.
	Cada decisión cuenta: el agua, el viento 
	y los objetos que encuentres pueden salvarte… 
	o hundirte."
]

var current_line := 0
var char_index := 0
var typing := false

func _ready():
#	siguiente.pressed.connect(_on_siguiente_pressed)
#	omitir.pressed.connect(_on_omitir_pressed)
#	if background_music != null:
#		background_music.play()  # Inicia la música de fondo
	start_typing()

func start_typing():
	story_label.text = ""
	char_index = 0
	typing = true
	if typing_timer != null:
		typing_timer.start()

func _on_typing_timer_timeout():
	if char_index < lines[current_line].length():
		story_label.text += lines[current_line][char_index]
		if typing_sound != null:
			typing_sound.play()  # Reproduce sonido de tipeo
		char_index += 1
	else:
		typing = false
		if typing_timer != null:
			typing_timer.stop()

func _on_siguiente_pressed():
	if typing:
		story_label.text = lines[current_line]
		typing = false
		if typing_timer != null:
			typing_timer.stop()
	elif current_line < lines.size() - 1:
		current_line += 1
		start_typing()
	else:
		finish_story()

func _on_omitir_pressed():
	finish_story()

func finish_story():
	if background_music != null:
		background_music.stop()  # Detiene la música al pasar al menú
	get_tree().change_scene_to_file("res://menu/Menu.tscn")
