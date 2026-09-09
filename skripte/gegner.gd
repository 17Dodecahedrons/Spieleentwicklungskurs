extends CharacterBody3D

const SPEED = 2.0
@onready var floor_detection = $RayCast3D
# Variablen um Gehen und Umdrehen zu kontrollieren
var keep_moving = true
var still_turning = false
signal trigger_loss()

func _physics_process(delta: float) -> void:
	# Schwerkraft
	var gravity = Vector3(0, -9.8, 0)
	if not is_on_floor():
		velocity += gravity * delta
	
	# Bewegung
	if keep_moving and is_on_floor():
		# Basiswechsel
		velocity = -global_transform.basis.z * SPEED
		# Überprüfe ob ein Abgrund vor uns ist
		if not floor_detection.is_colliding():
			keep_moving = false
	elif is_on_floor():
		# Nicht bewegen
		velocity.x = 0
		velocity.z = 0
		# Beginne umdrehen
		if not still_turning:
			still_turning = true
			# Drehe dich um
			var target_rotation = wrapf(rotation.y + PI, -PI, PI)
			# Dreh Animation per Tween
			var tween = create_tween()
			tween.tween_property(self, "rotation:y", target_rotation, 1.5)
			await tween.finished
			still_turning = false # Umdrehen ist fertig
			keep_moving = true # Wir können uns wieder bewegen
			
	# Kollisionen
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal() # Lineare Algebra Magie
			collider.apply_central_impulse(push_dir * 0.3 * SPEED)
		if collider.is_in_group("player"):
			trigger_loss.emit()
	
	move_and_slide()
