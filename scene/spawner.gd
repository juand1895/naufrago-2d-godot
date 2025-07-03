extends Node2D

@onready var timer = $Timer
#var heal_scene = preload("res://scene/Heal.tscn")
#var camera = get_viewport().get_camera_2d()
#var damage_scene = preload("res://scene/Damage.tscn")
var heal_scene = preload("res://scene/Heal.tscn")
var damage_scene = preload("res://scene/Damage.tscn")
@onready var camera = get_node("../Camera2D")

#func _ready():
#	timer.start()

#func _on_timer_timeout() -> void:
	#var obj
	#if randi() % 2 ==0:
	#	obj = heal_scene.instantiate()
	#else:
	#	obj = damage_scene.instantiate()
		
	#get_parent().add_child(obj)
	
	#var camera_pos = camera.global_position
	#var x = randi_range(int(camera_pos.x - 150), int(camera_pos.x + 150))
	#var y = camera_pos.y - 200
	#obj.global_position = Vector2(x, y)

	#print("Instanciado", obj)

func _on_heal_timer_timeout() -> void:
	var heal = heal_scene.instantiate()
	get_parent().add_child(heal)
	var camera_pos = camera.global_position
	var x = randi_range(int(camera_pos.x - 150), int(camera_pos.x + 150))
	var y = camera_pos.y - 200
	heal.global_position = Vector2(x, y)
	print("Heal instanciado")

func _on_damage_timer_timeout() -> void:
	var damage = damage_scene.instantiate()
	get_parent().add_child(damage)
	var camera_pos = camera.global_position
	var x = randi_range(int(camera_pos.x - 150), int(camera_pos.x + 150))
	var y = camera_pos.y - 250
	damage.global_position = Vector2(x, y)
	print("Damage instanciado")
	
