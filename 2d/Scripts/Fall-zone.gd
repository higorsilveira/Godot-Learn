extends Area2D

func _on_fallzone_body_entered(body):
	print(body.name)
	get_tree().reload_current_scene()
#	get_tree().change_scene("res://Levels/Level-001.tscn")
