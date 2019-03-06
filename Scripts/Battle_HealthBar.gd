extends HBoxContainer


#changing the babies health bar to match the desired health value
func _on_Interface_health_changed(health):
	$TextureProgress.value = health

#changing the players health bar to match the desired health value
func _on_Interface_BBY_health_changed(BBYhealth):
	$TextureProgress.value = BBYhealth
