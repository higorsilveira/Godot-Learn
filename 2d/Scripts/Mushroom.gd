extends KinematicBody2D

export var speed = 32
export var health = 2
var velocity = Vector2.ZERO
var move_direction = -1
var gravity = 1200
var hittted = false

func _physics_process(delta):
	velocity.x = speed * move_direction
	velocity.y += gravity * delta
	
	if move_direction == 1:
		$texture.flip_h = true
	else: $texture.flip_h = false
	
	_set_animation()
	
	velocity = move_and_slide(velocity)

func _on_anim_animation_finished(anim_name):
	if anim_name == "Idle":
		$texture.flip_h != $texture.flip_h
		$ray_wall.scale.x *= -1
		move_direction *= -1
		$anim.play("Run")

func _set_animation():
	var anim = "Run"
	
	if $ray_wall.is_colliding():
		anim = "Idle"
	elif velocity.x != 0:
		anim = "Run"
	
	if hittted == true:
		anim = "Hit"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func _on_hitBox_body_entered(body):
	hittted = true
	health -= 1
	body.velocity.y -= 300
	yield(get_tree().create_timer(0.2), "timeout")
	hittted = false
	if health < 1:
		get_node("hitBox/collision").set_deferred("disabled", true)
		queue_free()
