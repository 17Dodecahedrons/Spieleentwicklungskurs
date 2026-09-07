extends CharacterBody3D

const SPIELER_GESCHWINDIGKEIT = 5.0
const SPRUNGKRAFT = 4.5

func _physics_process(delta: float) -> void: # delta: Sekunden seitdem letztem Frame
	# Springen
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += SPRUNGKRAFT # Der Vektor 'velocity' gibt uns an, wohin wir uns bewegen
	
	# Schwerkraft
	var gravity = Vector3(0, -9.8, 0) # (X, Y, Z)
	if not is_on_floor():
		velocity += gravity * delta
		
	# Steuerung
	var input_dir = Input.get_vector("left", "right", "forward", "backward") # Vektor (-X, +X, -Y, +Y)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() # Einbettung
	if direction: # Tastendruck erkannt
		velocity.x = direction.x * SPIELER_GESCHWINDIGKEIT
		velocity.z = direction.z * SPIELER_GESCHWINDIGKEIT
	else: # Abbremsen
		velocity.x = move_toward(velocity.x, 0, SPIELER_GESCHWINDIGKEIT) # Aktuell, Zielwert, Schrittgröße
		velocity.z = move_toward(velocity.z, 0, SPIELER_GESCHWINDIGKEIT)
	
	move_and_slide() # Engine macht den Rest
