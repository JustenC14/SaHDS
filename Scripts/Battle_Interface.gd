extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal health_changed(health)
signal BBY_health_changed(BBYhealth)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

#sends a signal to player health node to change it
func _on_Health_health_changed(health):
	emit_signal("health_changed", health)
	

#sends a signal to baby health node to change it
func _on_BabyHealth_BBY_health_changed(BBYhealth):
	emit_signal("BBY_health_changed", BBYhealth)
