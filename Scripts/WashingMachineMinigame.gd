extends CanvasLayer

signal minigame_stop
var in_minigame = false
var collision_info
var speed = 30

# Minigame stage boolean and counter variables
# Moved clothes_loaded to global
# var clothes_loaded = false
var clothes_count = (randi() % 15 + 1) + 30
var EventTimer = (randi() % 6 + 1) + 4
var EventSelection = randi() % 3 + 1
var in_event = false
var background_time = 0.3
var not_throwing = true

# On launching the scene, make sure all of the minigame assets are hidden from view
# Because this is a canvas layer this is extra important, don't want clothes following the player around
func _ready():
	$TimeLabel.text = str(global.washingMachine_time)
	$TransparentLayer.hide()
	$WashingMachineSprite.hide()
	$InstructionLabel.hide()
	$InputPrompt.hide()
	$TimeLabel.hide()
	$Clothing.hide()
	$TransparentLayer.color = Color( 0.41, 0.41, 0.41, 0.5)

func _process(delta):
	
	# Checks to see if the player has completed loading the clothes or not.
	# If not, it displays the appropriate prompts for minigame play
	if in_minigame and not global.clothes_loaded:
		$InputPrompt.play("LoadClothes")
		$InstructionLabel.text = "LOAD THE CLOTHES!"
		$InputPrompt.show()
		
		# When the player presses spacebar, a piece of clothing is thrown into the machine
		if Input.is_action_just_pressed("ui_select"):
			clothes_count -= 1
			throw_clothes()
			
		# This code handles displaying the washing machine fill up with clothes
		if clothes_count > 20:
			$WashingMachineSprite.play("Door Open Empty")
		if clothes_count > 15 and clothes_count < 20:
			$WashingMachineSprite.play("Door Open Low Clothes")
		if clothes_count > 10 and clothes_count < 15:
			$WashingMachineSprite.play("Door Open Med Clothes")
		if clothes_count < 10:
			$WashingMachineSprite.play("Door Open Full Clothes")
		if clothes_count == 0:
			global.clothes_loaded = true
			$InstructionLabel.text = ""
			$WashingMachineSprite.play("Door Closed Running")
			$InputPrompt.hide()
			$TimeLabel.show()
	
	# While the machine is running, Keep selecting a random event to run when the machine does break down
	if in_minigame and global.clothes_loaded and not in_event:
		EventTimer -= delta
		EventSelection = randi() % 3 + 1
		
	# Machine stall event code. Completed
	if EventSelection == 1 and EventTimer < 0 and in_minigame:
		in_event = true
		$InstructionLabel.text = "STALLED! KICK IT!"
		$InputPrompt.show()
		$WashingMachineSprite.play("Event Stalling")
		background_time -= delta
		
		if Input.is_action_pressed("ui_select"):
			in_event = false
			$InstructionLabel.text = ""
			$InputPrompt.hide()
			EventTimer = (randi() % 6 + 1) + 4
			$WashingMachineSprite.play("Door Closed Running")
			$TransparentLayer.color = Color( 0.41, 0.41, 0.41, 0.5)

	# Machine off balance code. Incomplete
	if EventSelection == 2 and EventTimer < 0 and in_minigame:
		in_event = true
		$InstructionLabel.text = "REGAIN BALANCE!"
		$InputPrompt.show()
		
		
		if Input.is_action_pressed("ui_select"):
			in_event = false
			$InstructionLabel.text = ""
			$InputPrompt.hide()
			EventTimer = (randi() % 6 + 1) + 4

	# Machine overheated code. Incomplete
	if EventSelection == 3 and EventTimer < 0 and in_minigame:
		in_event = true

		$InstructionLabel.text = "OVERHEATED! COOL IT!"
		$InputPrompt.show()
		
		if Input.is_action_pressed("ui_select"):
			in_event = false
			$InstructionLabel.text = ""
			$InputPrompt.hide()
			EventTimer = (randi() % 6 + 1) + 4
	
	if Input.is_action_pressed("ui_cancel") and in_minigame:
		end_wm_minigame()

func launch_wm_minigame():
	$TransparentLayer.show()
	$WashingMachineSprite.show()
	$InstructionLabel.show()
	$WasherTimer.start()
	in_minigame = true
	
	if global.clothes_loaded:
		$TimeLabel.show()
		$WashingMachineSprite.play("Door Closed Running")
	
	
func end_wm_minigame():
	$TransparentLayer.hide()
	$WashingMachineSprite.hide()
	$InstructionLabel.hide()
	$InputPrompt.hide()
	$WasherTimer.stop()
	$TimeLabel.hide()
	in_minigame = false
	emit_signal("minigame_stop")

func _on_WasherTimer_timeout():
	if in_minigame and global.washingMachine_time > 0 and global.clothes_loaded and not in_event:
		global.washingMachine_time -= 1
		$TimeLabel.text = str(global.washingMachine_time)


func _on_WashingMachineSprite_frame_changed():
	if $WashingMachineSprite.animation == "Event Stalling":
		if $TransparentLayer.color == (Color(1, 0, 0, 0.5 )):
			$TransparentLayer.color = Color( 0.41, 0.41, 0.41, 0.5)
		else:
			$TransparentLayer.color = Color(1, 0, 0, 0.5)
	else:
		$TransparentLayer.color = Color( 0.41, 0.41, 0.41, 0.5)  

func throw_clothes():
	if not_throwing and clothes_count > 1:
		not_throwing = false
		$Clothing.show()
		
		var selector = randi()%3
		if selector == 0:
			$Clothing.play("Throw Shirt")
		if selector == 1:
			$Clothing.play("Throw Underwear")
		if selector == 2:
			$Clothing.play("Throw Pants")


func _on_Clothing_animation_finished():
	$Clothing.play("Empty")
	$Clothing.hide()
	not_throwing = true