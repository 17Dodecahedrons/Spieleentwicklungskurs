extends Node3D

const ROTATIONS_GESCHWINDIGKEIT = 2.0

func _process(delta: float) -> void:
	# Rotiere
	rotate_y(ROTATIONS_GESCHWINDIGKEIT * delta)
