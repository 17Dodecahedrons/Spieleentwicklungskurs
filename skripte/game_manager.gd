extends Node3D

@onready var defeat_screen = $CanvasLayerDefeat
@onready var win_screen = $CanvasLayerDefeat/CanvasLayerWin
@onready var death_barrier = get_tree().current_scene.find_child("DeathBarrier")
@onready var coins = get_tree().current_scene.find_child("Coins")
@onready var coin_count = coins.get_child_count()
var current_coins = 0
var game_over = false

######################## Münzenlogik
func _collected_coin() -> void:
	current_coins += 1
	if current_coins == coin_count:
		_trigger_win()
		
######################## Starteinstellungen

func _ready() -> void:
	defeat_screen.hide()
	win_screen.hide()
	
	# Signal
	if death_barrier.has_signal("trigger_loss"):
		death_barrier.trigger_loss.connect(_trigger_loss)
		
	for coin in coins.get_children():
		if coin.has_signal("collected"):
			coin.collected.connect(_collected_coin)
		
######################## Game Over Bildschirm		

func _trigger_win() -> void:
	game_over = true
	win_screen.show()
	get_tree().paused = true

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
