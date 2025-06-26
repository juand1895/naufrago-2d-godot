extends Node2D


func _on_heal_item_body_entered(body: Node2D) -> void:
	if body.name == "Player":  
		if body.has_method("heal"):
			body.heal(20)
		queue_free()  # Desaparece
