extends Node3D

@onready var defeat_screen = $CanvasLayerDefeat

func _ready() -> void:
	defeat_screen.hide()
	
	# Finde Death Barrier in der Szene
	var death_barrier = get_tree().current_scene.find_child("DeathBarrier")
	if death_barrier.has_signal("trigger_loss"):
		death_barrier.trigger_loss.connect(_trigger_loss)
		
func _trigger_loss() -> void:
	defeat_screen.show()
	get_tree().paused = true
