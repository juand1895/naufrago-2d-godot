extends Area2D

# ⚙️ VARIABLES CONFIGURABLES desde el Inspector
@export var tipo_objeto: String = "moneda"  # Tipo: "moneda", "vida", "dano"
@export var velocidad: float = 200.0        # Velocidad de caída

func _ready():
	# 🎨 CONFIGURAR APARIENCIA según el tipo de objeto
	match tipo_objeto:
		"moneda":
			$Sprite2D.texture = preload("res://assets/moneda.png")
			$Sprite2D.scale = Vector2(0.3, 0.3)
		"vida":
			$Sprite2D.texture = preload("res://assets/vida.png") 
			$Sprite2D.scale = Vector2(0.3, 0.3)
		"dano":
			$Sprite2D.texture = preload("res://assets/dano.png")
			$Sprite2D.scale = Vector2(0.3, 0.3)
	
	# 🔗 CONECTAR SEÑAL de colisión
	body_entered.connect(_on_body_entered)
	print("✅ Objeto ", tipo_objeto, " listo para caer")

func _physics_process(delta):
	# ⬇️ MOVIMIENTO hacia abajo
	position.y += velocidad * delta
	
	# 🗑️ ELIMINAR si sale de la pantalla
	if position.y > 1200:
		queue_free()

func _on_body_entered(body):
	# 🎯 DETECTAR si colisiona con el JUGADOR
	if body.is_in_group("jugador"):
		print("🎯 Colisión con jugador - Tipo: ", tipo_objeto)
		
		# 🎪 APLICAR EFECTO según tipo de objeto
		match tipo_objeto:
			"moneda":
				GameManager.agregar_puntos(10)  # 🤑 +10 puntos
				print("💰 +10 puntos")
			"vida":
				GameManager.cambiar_vida(15)    # ❤️ +15 vida
				print("❤️ +15 vida")
			"dano":
				GameManager.cambiar_vida(-25)   # 💀 -25 vida  
				print("💀 -25 vida")
		
		# 🗑️ ELIMINAR objeto después de colisionar
		call_deferred("queue_free")
