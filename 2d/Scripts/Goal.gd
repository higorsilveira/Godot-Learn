extends Area2D


func _ready():
	pass


func _on_Goal_body_entered(body):
	if body.name == "Player":
		$anim.play("finished")
		$confete.emitting = true
