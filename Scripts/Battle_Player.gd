extends RigidBody2D

# class member variables go here:
var health = 100
var AttName


#damage value for player, needs to be fixed so each attack has a specific damage, should be combined with the attack function
func PlayerDmg():
	var dmg = 20
	return(dmg)
	
#naming the player attack values for the attack_UI
func Attack(b):
	var array = ["boom", "attack", "pooball", "scream"]

	return(array[b])

#player takes dmg getter
func TakeDmg(Dmg):
	$Health.take_damage(Dmg)
	
	
	
		

#func _ready():
#	for i in range(4):
#		print(array[i])
#	pass

#func _process(delta):

#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.






	
