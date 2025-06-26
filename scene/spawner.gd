extends Node2D

@onready var timer = $Timer
@onready var heal_scene = preload("res://scene/Heal.tscn")
@onready var camera = get_viewport().get_camera_2d()

func _ready():
	timer.start()

func _on_timer_timeout() -> void:
	var heal = heal_scene.instantiate()
	get_parent().add_child(heal)
	
	var camera_pos = camera.global_position
	var x = randi_range(int(camera_pos.x - 150), int(camera_pos.x + 150))
	var y = camera_pos.y - 200
	
	heal.global_position = Vector2(x, y)
	print("Instanciado", heal.global_position)
	
	
	
