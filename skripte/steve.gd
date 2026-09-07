extends CharacterBody3D

const SPIELER_GESCHWINDIGKEIT = 5.0
const SPRUNGKRAFT = 4.5
@onready var steve_mesh = $MeshInstance3D
@onready var steve_col = $CollisionShape3D

func _physics_process(delta: float) -> void: # delta: Sekunden seitdem letztem Frame
	# Springen
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += SPRUNGKRAFT # Der Vektor 'velocity' gibt uns an, wohin wir uns bewegen
	
	# Schwerkraft
	var gravity = Vector3(0, -9.8, 0) # (X, Y, Z)
	if not is_on_floor():
		velocity += gravity * delta
		
	# Sprinten
	var neue_geschwindigkeit = SPIELER_GESCHWINDIGKEIT
	if Input.is_action_pressed("sprint"):
		neue_geschwindigkeit = 2 * SPIELER_GESCHWINDIGKEIT	
		
	# Ducken
	if Input.is_action_pressed("crouch"):
		neue_geschwindigkeit = 0.5 * SPIELER_GESCHWINDIGKEIT
		# Höhe anpassen
		steve_mesh.mesh.height = 1
		steve_col.shape.height = 1
		# Richtig positionieren
		steve_mesh.position.y = -0.5
		steve_col.position.y = -0.5
	else:
		# Höhe anpassen
		steve_mesh.mesh.height = 2
		steve_col.shape.height = 2
		# Richtig positionieren
		steve_mesh.position.y = 0
		steve_col.position.y = 0
		
	# Steuerung
	var input_dir = Input.get_vector("left", "right", "forward", "backward") # Vektor (-X, +X, -Y, +Y)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() # Einbettung
	if direction: # Tastendruck erkannt
		velocity.x = direction.x * neue_geschwindigkeit
		velocity.z = direction.z * neue_geschwindigkeit
	else: # Abbremsen
		velocity.x = move_toward(velocity.x, 0, neue_geschwindigkeit) # Aktuell, Zielwert, Schrittgröße
		velocity.z = move_toward(velocity.z, 0, neue_geschwindigkeit)
	
	move_and_slide() # Engine macht den Rest
