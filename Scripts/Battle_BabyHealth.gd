extends Node2D

signal BBY_health_changed(BBYhealth)

var BBYhealth = 0
#exporting allows for the variable to be changed without access to code
export(int) var max_health = 100


func _ready():
	#starting health value
	BBYhealth = max_health
	emit_signal("BBY_health_changed", BBYhealth)

#damage applied to baby, then printed to debugger window
#paramater "amount" is the damage done to the baby
func take_damage(amount):
	BBYhealth -= amount
	BBYhealth = max(0, BBYhealth)
	emit_signal("BBY_health_changed", BBYhealth)
	print(BBYhealth)