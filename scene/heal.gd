extends Node2D

@export var fall_speed := 100 #velocidad de caida

func _process(delta):
	position.y += fall_speed * delta
	
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()

func _on_heal_item_body_entered(body: Node2D) -> void:
	if body.name == "Player":  
		if body.has_method("heal"):
			body.heal(20) #los puntos de vida que da
		queue_free()  # Desaparece
