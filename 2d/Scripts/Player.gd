extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 480
var gravity = 1200
var jump_force = -720
var is_grounded
onready var raycasts = $raycasts

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity * delta	
	_get_input()
	velocity = move_and_slide(velocity)
	is_grounded = _check_is_ground()
	_set_animation()

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move-right"))- int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)

	if move_direction != 0:
		$texture.scale.x = move_direction	

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
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)
