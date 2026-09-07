extends Node3D

@onready var defeat_screen = $CanvasLayerDefeat
var game_over = false

func _ready() -> void:
	defeat_screen.hide()
	
	# Finde Death Barrier in der Szene
	var death_barrier = get_tree().current_scene.find_child("DeathBarrier")
	if death_barrier.has_signal("trigger_loss"):
		death_barrier.trigger_loss.connect(_trigger_loss)
		
func _trigger_loss() -> void:
	game_over = true
	defeat_screen.show()
	get_tree().paused = true
	
func _unhandled_input(event: InputEvent) -> void:
	if not game_over:
		return
	# Maus freilassen
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Neustart
	if Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
