extends Node3D

const ROTATIONS_GESCHWINDIGKEIT = 2.0
@onready var coin_body = $Area3D
# Mehrfachkollisionen verhindern mit Schalter
var allow_collision = true

func _ready() -> void:
	# Signal
	coin_body.body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	# Rotiere
	rotate_y(ROTATIONS_GESCHWINDIGKEIT * delta)
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("player") and allow_collision:
		allow_collision = false
		# Tween
		var tween = create_tween()
		tween.tween_property(self, "position:y", self.position.y + 1.5, 0.1)
		await tween.finished
		queue_free() # Lösche mich selbst
