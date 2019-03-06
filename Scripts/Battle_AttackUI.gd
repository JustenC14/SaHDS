extends Node2D

var something
#global variables
var AttackArray = []

#passing in attack names as an array  
func GetAttackName(val, AttackName1):#, AttackName2, AttackName3, AttackName4):
			AttackArray.insert(val,AttackName1)



#working on attack array	
#func DisplayAttackName(i):
#	for i in range(4):
#		print(AttackArray[i])
#		return(AttackArray[i])
	
	

func _process(delta):
	#displays attacks in correct location every frame
	$Button/Label.set_text(AttackArray[0])
	$Button2/Label.set_text(AttackArray[1])
	$Button3/Label.set_text(AttackArray[2])
	$Button4/Label.set_text(AttackArray[3])
	pass


#testing
func Test():
	something = "No"