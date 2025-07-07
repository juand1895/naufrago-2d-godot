extends Node2D


@onready var sprite1 = $Sprite1
@onready var sprite2 = $Sprite2
@export var scroll_speed := 400
#@export var background_height := 648

#var sprites := []

#func _ready():

#	sprites = get_children()
func _process(delta):
	sprite1.position.y += scroll_speed * delta
	sprite2.position.y += scroll_speed * delta

	var height = sprite1.texture.get_height()

	if sprite1.position.y >= height:
		sprite1.position.y = sprite2.position.y - height

	if sprite2.position.y >= height:
		sprite2.position.y = sprite1.position.y - height

#func _process(delta):
#	for sprite in sprites:
#		sprite.position.y += scroll_speed * delta

		# Si se va por debajo de la pantalla, lo vuelve arriba
#		if sprite.position.y >= background_height:
#			sprite.position.y -= 2 * background_height
