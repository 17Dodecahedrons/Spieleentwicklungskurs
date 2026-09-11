extends Node3D

@onready var defeat_screen = $CanvasLayerDefeat
@onready var win_screen = $CanvasLayerVictory
@onready var hud_label = $CanvasLayerHUD/Label
@onready var blur_screen = $CanvasLayerBlur
@onready var death_barrier = get_tree().current_scene.find_child("DeathBarrier")
@onready var coins = get_tree().current_scene.find_child("Coins")
@onready var player = get_tree().current_scene.find_child("Steve").find_child("CharacterBody3D")
@onready var enemies = get_tree().current_scene.find_child("Gegner")
@onready var coin_count = coins.get_child_count()
var current_coins = 0
var game_over = false

######################## Münzenlogik
func _collected_coin() -> void:
	current_coins += 1
	_update_hud()
	if current_coins == coin_count:
		_trigger_win()
		
func _update_hud() -> void:
	hud_label.text = "Coins: " + str(current_coins) + " / " + str(coin_count)
	
######################## Gegner Managen

func _delete_enemy(body: CharacterBody3D) -> void:
	var enemy_root = body.get_parent()
	enemy_root.queue_free()
		
######################## Starteinstellungen

func _ready() -> void:
	defeat_screen.hide()
	win_screen.hide()
	blur_screen.hide()
	_update_hud()
	
	# Signal
	if death_barrier.has_signal("trigger_loss"):
		death_barrier.trigger_loss.connect(_trigger_loss)
		
	if player.has_signal("trigger_loss"):
		player.trigger_loss.connect(_trigger_loss)
		pass
		
	if player.has_signal("defeat_enemy"):
		player.defeat_enemy.connect(_delete_enemy)
		
	for enemy in enemies.get_children():
		var enemy_body = enemy.find_child("CharacterBody3D")
		if enemy_body.has_signal("trigger_loss"):
			enemy_body.trigger_loss.connect(_trigger_loss)
		
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
	blur_screen.show()
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
