extends Node3D

const ROTATIONS_GESCHWINDIGKEIT = 2.0
@onready var coin_body = $Area3D
signal collected()
# Mehrfachkollisionen verhindern mit Schalter
var allow_collision = true

func _process(delta: float) -> void:
	# Rotiere
	rotate_y(ROTATIONS_GESCHWINDIGKEIT * delta)
	# Signal
	coin_body.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("player") and allow_collision:
		allow_collision = false
		collected.emit()
		queue_free() # Lösche mich selbst
