extends Item

func apply_effect(player):
	player.take_damage(10)




func _on_damage_item_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if body.has_method("take_damage"):
			body.take_damage(30)  # estos son los puntos que quita
		queue_free()
