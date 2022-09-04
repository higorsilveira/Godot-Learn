extends Area2D

export var fruits = 1

func _on_items_body_entered(body):
	Global.fruits += fruits
	print(Global.fruits)
	$anim.play("Collected")

func _on_anim_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()
