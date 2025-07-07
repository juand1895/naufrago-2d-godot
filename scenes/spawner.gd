extends Node2D

@onready var timer = $Timer

var heal_scene = preload("res://scenes/items/Heal.tscn")
var damage_scene = preload("res://scenes/items/Damage.tscn")

var camera: Camera2D

#func _ready():
#	camera = get_viewport().get_camera_2d()

func _on_heal_timer_timeout() -> void:
	var heal = heal_scene.instantiate()
	get_parent().add_child(heal)
	var camera = get_viewport().get_camera_2d()
	if camera == null:
		push_error("No se encontró una cámara activa.")
		return
	
	var camera_pos = camera.global_position
	var x = randi_range(int(camera_pos.x - 150), int(camera_pos.x + 150))
	var y = camera_pos.y - 200
	heal.global_position = Vector2(x, y)
	print("Heal instanciado")

func _on_damage_timer_timeout() -> void:
	var damage = damage_scene.instantiate()
	get_parent().add_child(damage)
	
	var camera = get_viewport().get_camera_2d()
	if camera == null:
		push_error("No se encontró una cámara activa.")
		return
	var camera_pos = camera.global_position
	var x = randi_range(int(camera_pos.x - 150), int(camera_pos.x + 150))
	var y = camera_pos.y - 250
	damage.global_position = Vector2(x, y)
	print("Damage instanciado")
	
