extends Area2D

var flagon = false

func _ready():
	pass

func _on_Checkpoint_body_entered(body):
	if body.name == "Player" and !flagon:
		body.hit_checkpoint()
		$anim.play("flag_out")
		flagon = true


func _on_anim_animation_finished(anim_name):
	$anim.play("flag_idle") # Replace with function body.
