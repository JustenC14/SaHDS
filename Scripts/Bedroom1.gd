extends Node2D

# Signals
signal InMinigame

# Minigame variables
var in_minigame = false

func _ready():
	if global.PLAYER_IN_BATTLE:
		$Player.position.x = global.player_x
		$Player.position.y = global.player_y
		global.PLAYER_IN_BATTLE = 0
	else:
		$Player.position = $LoadPosition.position
		global.player_location = "Bedroom1"
	if global.baby_location == "Bedroom1":
		#$Baby.position = global.baby_position
		print($Baby.position)
		$Baby.position.x = global.baby_position_x
		$Baby.position.y = global.baby_position_y
		$Baby.show()
	else:
		$Baby.hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_Action():
	var collision_info = $Player.get_last_collision_info()
	
	if collision_info == "null":
		print("Interacted w/ Air @ ", OS.get_time())
		$Player/HealthBar.show()
		$Player/FatigueBar.show()
		$Player/ViewStatusTimer.start()
	
	
	if collision_info == "WashingMachine":
		print("Interacted w/ WashingMachine @ ", OS.get_time())
		emit_signal("InMinigame")
		get_tree().paused = true
		$WashingMachineMinigame.launch_wm_minigame()
	
	if collision_info == "Baby":
		print("Interacted w/ Baby @ ", OS.get_time())
		global.baby_position_x = $Baby.position.x
		global.baby_position_y = $Baby.position.y
		global.player_x = $Player.position.x
		global.player_y = $Player.position.y
		global.PLAYER_IN_BATTLE = 1
		get_tree().change_scene("res://Scenes/Main_Battle.tscn")
		


func _on_WashingMachineMinigame_minigame_stop():
	$Player.exit_minigame()
	get_tree().paused = false


func _on_Area2D_area_entered(area):
	print("entered")


func _on_Player_Bedroom12Kitchen():
	global.baby_position_x = $Baby.position.x
	global.baby_position_y = $Baby.position.y
	get_tree().change_scene("res://Scenes/Kitchen.tscn")
