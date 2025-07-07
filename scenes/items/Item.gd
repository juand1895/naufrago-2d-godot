extends Area2D
class_name Item

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		apply_effect(body)
		queue_free()

func apply_effect(player):
	# Sobrescribir en clases hijas
	pass
