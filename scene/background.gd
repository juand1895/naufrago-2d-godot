extends Node2D

@export var scroll_speed := 400
@export var background_height := 648

var sprites := []

func _ready():
	sprites = get_children()

func _process(delta):
	for sprite in sprites:
		sprite.position.y += scroll_speed * delta

		# Si se va por debajo de la pantalla, lo vuelve arriba
		if sprite.position.y >= background_height:
			sprite.position.y -= 2 * background_height
