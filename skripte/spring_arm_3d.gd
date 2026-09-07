extends SpringArm3D

const MAUS_EMPFINDLICHKEIT = 0.005

func _ready() -> void:
	# Maus einfangen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event: InputEvent) -> void:
	# Maus freilassen
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		return
	# Maus einfangen
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Falls Maus frei, tu nichts
	if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		return
	
	# Kamerabewegung
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * MAUS_EMPFINDLICHKEIT # Mausbewegung links/rechts. Drehe um y-Achse
		rotation.y = wrapf(rotation.y, 0.0, TAU) # Wenn wir Tau = 2 * Pi überschreiten, fang wieder bei 0.0 an und vice versa
		rotation.x -= event.relative.y * MAUS_EMPFINDLICHKEIT # Mausbewegung hoch/runter. Drehe um x-Achse
		rotation.x = clamp(rotation.x, -PI/2, PI/2) # Unterschreite nicht -PI/2, Überschreite nicht PI/2
