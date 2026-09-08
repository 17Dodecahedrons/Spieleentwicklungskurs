extends Area3D

const ROTATIONS_GESCHWINDIGKEIT = 2.0

func _process(delta: float) -> void:
	# Rotiere
	rotate_y(ROTATIONS_GESCHWINDIGKEIT * delta)
	# Signal
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		queue_free() # Lösche mich selbst
