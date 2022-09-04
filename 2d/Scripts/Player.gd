extends KinematicBody2D

var up = Vector2.UP
var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded
var player_health = 3
var max_health = 3
var hurted = false
var knockback_dir = 1
var knockback_force = 600
onready var raycasts = $raycasts

signal change_life(player_life)


func _ready():
	connect("change_life", get_parent().get_node("HUD/HBoxContainer/Life"), "on_change_life")
	emit_signal("change_life", max_health)
	position.x = Global.checkpoint_pos
	position.y = 0

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = 0
	
	if !hurted:
		_get_input()
	velocity = move_and_slide(velocity, up)
	is_grounded = _check_is_ground()
	_set_animation()
	
	for plataforms in get_slide_count():
		var collision = get_slide_collision(plataforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move-right"))- int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)

	if move_direction != 0:
		$texture.scale.x = move_direction
		knockback_dir = move_direction

func _input(event):
	if event.is_action_pressed("jump") && is_grounded:
		velocity.y = jump_force/2
			
func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	var anim = "Idle"
	
	if !is_grounded:
		if velocity.y <= 0:
			anim = "Jump"
		else: anim = "Fall"
	elif velocity.x != 0:
		anim = "Run"
		
	if hurted:
		anim = "Hit"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	velocity.x = -knockback_dir * knockback_force
	velocity.y = -knockback_force / 4
	velocity = move_and_slide(velocity)

func _on_hurtBox_body_entered(body):
	player_health -= 1
	hurted = true
	emit_signal("change_life", player_health)
	knockback()
	get_node("hurtBox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5),"timeout")
	get_node("hurtBox/collision").set_deferred("disabled", false)
	hurted = false
	if player_health < 1:
		queue_free()
		get_tree().reload_current_scene()

func hit_checkpoint():
	Global.checkpoint_pos = position.x
