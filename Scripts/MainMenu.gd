extends CanvasLayer

var current_selection = "start"

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("move_up"):
		pass
	if Input.is_action_pressed("move_down"):
		if current_selection == "start":
			current_selection = "load"

func _on_StartButton_pressed():
	get_tree().change_scene("res://Scenes/Bedroom1.tscn")