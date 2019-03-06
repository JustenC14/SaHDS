extends Node2D

# Signals
signal InMinigame

# Minigame variables
var in_minigame = false

func _ready():
	$Player.position = $LoadPosition.position
	global.player_location = "Kitchen"

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
	
	if collision_info == "Stove":
		print("Interacted w/ Stove @ ", OS.get_time())
	
	if collision_info == "CuttingBoard":
		print("Interacted w/ CuttingBoard @ ", OS.get_time())
		#emit_signal("InMinigame")
		#get_tree().paused = true
		#$WashingMachineMinigame.launch_wm_minigame()
	


func _on_Player_Kitchen2Bedroom1():
	get_tree().change_scene("res://Scenes/Bedroom1.tscn")
