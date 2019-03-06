extends Node2D

# class member variables go here:
var Attacking = false
var IsAttacking = false
var playerturn = true
var babyturn = false
var UserInput
var BabyAttack


func _ready():
	
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass



func _process(delta):
	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	
	#calls to playerAttacks list
	PlayerAttacks()
	#game continues until one of the two characters runs out of health
	if $Baby/BabyHealth.BBYhealth > 0 and $Player/Health.health > 0:
		##if playerturn:
			##$BabyTurn.stop()
			##if Input.is_action_pressed("press_1") and !IsAttacking:
				##IsAttacking = true
				#$Baby.TakeDmg($Player.PlayerDmg())
				#UserInput = "Attack1"
				#$AttackTimer.start()
				#$PlayerTurnTimer.start()
				
	
		#logic for babyturn
		if babyturn and !Attacking:
			Attacking = true
			$AttackTimer.stop()
			$PlayerTurnTimer.stop()
			#starts the baby attack animation
			$BabyAttackTimer.start()
			#sets the blink attack animation to play
			BabyAttack = "Attack1"
			print("babyturn")
			#damage dealt to player
			$Player.TakeDmg($Baby.BbyDmg())
			$BabyTurn.start()

	else:
		#call to main scene which brings you back to overworld
		get_tree().change_scene("res://Scenes/Bedroom1.tscn")
		
		
#   
#	bool playerturn
#	bool Babyturn
#

#		if playerturn:
#			battle
#			playerturn = false
#			babyturn = true
		
	
	
	#Code example for attack one, only implemented baby attack
	if BabyAttack == "Attack1":
		$Baby/AnimatedSprite.animation = "blink"
	else:
		$Baby/AnimatedSprite.animation = "default"
	
	
	
	if UserInput == "Attack1":
		$Player/AnimatedSprite.animation = "Blink"
	else:
		$Player/AnimatedSprite.animation = "default"
	

	pass

#timer
func _on_AttackTimer_timeout():
	UserInput = "default"
	##IsAttacking = false
	##babyturn = true
	
	

#starts the babies turn at the end of the timer
func _on_PlayerTurnTimer_timeout():
		babyturn = true
		
		
#shows the UI for the player and allows them to select a move also ends the baby turn
func _on_BabyTurn_timeout():
	$BabyTurn.stop()
	$BabyAttackTimer.stop()
	Attacking = false
	babyturn = false
	$"Attack UI".show()

#allows player moves to be changed from the Player class for future use of added attacks
func PlayerAttacks():
	var TempArray = []
	for i in range(4):
		$"Attack UI".GetAttackName(i,$Player.Attack(i))

#sets the baby animation back to default and ends the attack animation
func _on_BabyAttackTimer_timeout():
	BabyAttack = "default"
	

#damage and animations played for the first attack
func _on_Button_pressed():
	UserInput = "Attack1"
	$"Attack UI".hide()
	$AnimationTimer.set_wait_time(2)
	$AnimationTimer.start()
	$AttackTimer.start()
	$PlayerTurnTimer.start()



#damage and animations for the second attack
func _on_Button2_pressed():
	$"Attack UI".hide()
	$AttackTimer.start()
	$Player/AnimationPlayer/AnimatedSprite2.show()
	$Player/AnimationPlayer.set_current_animation("Move")
	#sets animation timer to length of the animation to make it look smooth
	$AnimationTimer.set_wait_time($Player/AnimationPlayer.current_animation_length)
	$AnimationTimer.start()
	$PlayerTurnTimer.start()

#ends the animations of the attacks
func _on_AnimationTimer_timeout():
	$AnimationTimer.stop()
	$Player/AnimationPlayer/AnimatedSprite2.hide()
	$Player/AnimationPlayer2/AnimatedSprite3.hide()
	$Player/AnimatedSprite4.hide()
	#passes in the damage the player does to the baby
	$Baby.TakeDmg($Player.PlayerDmg())
	#ends the player attacks animation
	$Player/AnimationPlayer.stop(true)
	$Player/AnimationPlayer2.stop(true)


func _on_Button3_pressed():
	$"Attack UI".hide()
	$AttackTimer.start()
	$Player/AnimationPlayer2/AnimatedSprite3.show()
	$Player/AnimationPlayer2.set_current_animation("Throw")
	#$Baby.is_poisoned(true)
	#sets animation timer to length of the animation to make it look smooth
	$AnimationTimer.set_wait_time($Player/AnimationPlayer2.current_animation_length)
	$AnimationTimer.start()
	$PlayerTurnTimer.start()
	
	


func _on_Button4_pressed():
	$"Attack UI".hide()
	$AttackTimer.start()
	$Player/AnimatedSprite4.show()
	$AnimationTimer.set_wait_time(1)
	$AnimationTimer.start()
	$PlayerTurnTimer.start()
