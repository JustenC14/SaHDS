extends KinematicBody2D

# Player Action Signals
signal Action
signal Bedroom12Kitchen
signal Kitchen2Bedroom1

# Global Collision Variables
var collision_info
var last_collided_with

# Variables that facilitate minigame play

func _ready():
	$AnimatedSprite.play("Standing_Down")
	$HealthBar.hide()
	$FatigueBar.hide()


func _process(delta):
	var velocity = Vector2()
	#######################################################################################################################
	#####################################PLAYER MOVEMENT###################################################################
	#######################################################################################################################
	# Getting movement input from the user
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite.play("Walking_Right")
		velocity.x += 1
	
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite.play("Walking_Left")
		velocity.x -= 1
	
	if Input.is_action_pressed("move_up"):
		if velocity.x == 0:
			$AnimatedSprite.play("Walking_Up")
		velocity.y -= 1
	
	if Input.is_action_pressed("move_down"):
		if velocity.x == 0:
			$AnimatedSprite.play("Walking_Down")
		velocity.y += 1
	
	# These if statments handle when the player is moving and stops. It ensures that the animation that plays
	# After stopping makes sense (ie, walking down means you stop facing down)
	if velocity.length() == 0 && Input.is_action_just_released("move_down"):
		$AnimatedSprite.play("Standing_Down")
		
	if velocity.length() == 0 && Input.is_action_just_released("move_up"):
		$AnimatedSprite.play("Standing_Up")
		
	if velocity.length() == 0 && Input.is_action_just_released("move_left"):
		$AnimatedSprite.play("Standing_Left")
		
	if velocity.length() == 0 && Input.is_action_just_released("move_right"):
		$AnimatedSprite.play("Standing_Right")
	
	# Normalizing the velocity vector to 1 and multiplying it by our speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * global.player_speed
		last_collided_with = "null"
	
	# This gets all of the collision info from the move_and_collide variable
	# it stores it in the collision_info variable for later use
	collision_info = move_and_collide(velocity * delta)
	
	# This is used to store the last collision, just in case the user stops moving but interacts
	if collision_info: # If collision info exists
		if collision_info.collider.name: # If it has a name
			
			# Set last_collided_with to be the string of the name of the item collided with
			# Possibilites include Stove, WashingMachine, Countertop, Doors, ETC.
			last_collided_with = collision_info.collider.name
			
			# This code handles traveling between rooms in the game. This is probably poor practice, but oh well.
			if collision_info.collider.name == "Bedroom12Kitchen": # Read this as Bedroom 1 -> Kitchen
				emit_signal("Bedroom12Kitchen")
			if collision_info.collider.name == "Kitchen2Bedroom1": # Read this as Kitchen -> Bedroom 1
				emit_signal("Kitchen2Bedroom1")
	
	# this makes the player move (wow)
	position += velocity * delta
	
	
	##################################################PLAYER ACTIONS#######################################################
	# IF the player presses E, emit the signal to the scene that the player is trying to interact
	# This could do a number of things depending on the scene (launch minigame, show stats, etc)
	if Input.is_action_pressed("interact"):
		emit_signal("Action")
		
	##################################################PLAYER STAT VARIABLES##############################################
	# Constant updating of the health and fatigue for the player to keep track of.
	$HealthBar.value = global.player_health
	$FatigueBar.value = global.player_fatigue

# Function that main will use to get Collider name for minigame launch/Interaction
func get_last_collision_info():
	return last_collided_with

# When entering a minigame, this hides the player so it looks nicer i guess
func _on_Node2D_InMinigame():
	$AnimatedSprite.stop() # This prevents walking in place when launching a minigame
	$AnimatedSprite.hide()
	
# Makes the player visible again upon exiting a minigame
func exit_minigame():
	$AnimatedSprite.show() 

# When the player presses E, the stats are shown for a short time, when this time is over
# Hide them again
func _on_ViewStatusTimer_timeout():
	$HealthBar.hide()
	$FatigueBar.hide()
