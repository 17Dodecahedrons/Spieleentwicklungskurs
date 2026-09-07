extends Area3D

signal trigger_loss()

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node3D):
	if body.is_in_group("player"):
		trigger_loss.emit()
