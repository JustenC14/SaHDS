extends RigidBody2D

# class member variables go here:
# var a = 2
# var b = "textvar"
var health = 100

#the damage of the baby characters attacks
func BbyDmg():
	var dmg = 20
	return(dmg)

#Damage applied to baby health value
func TakeDmg(Dmg):
	$BabyHealth.take_damage(Dmg)
	

#Working on creating a "dot" or Dmg over time system
#func is_poisoned(var poisoned):
#	var count 
#	var ispois
#	ispois = poisoned
#	if poisoned and count < 2:
#		$BabyHealth.take_damage(5)
#		count+=1
#	else:
#		poisoned = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
