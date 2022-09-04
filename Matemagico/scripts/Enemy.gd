extends KinematicBody2D

var velocity: Vector2
export(int) var speed
var n1: int
var n2: int
var opint: int
var op: String
var res: int
var i: int

func _ready():
	randi_calc()
	load_labels()
	i = randi() % 2

func randi_calc():
	n1 = randi() % 10
	n2 = randi() % 10
	opint = randi() % 2
	
	print(opint)
	
	if opint == 0:
		op = "+"
		res = n1 + n2
	elif opint == 1:
		op = "-"
		res = n1 - n2

func load_labels():
	$n1.text = str(n1)
	$op.text = str(op)
	$n2.text = str(n2)
	$res.text = str(res)

func _physics_process(_delta):
	moveUp()
#	out_of()
	
func moveUp():
	var direction_vetor: Vector2 = Vector2.ZERO
	if i == 0:
		direction_vetor = Vector2.UP + Vector2.RIGHT/3
	elif i == 1:
		direction_vetor = Vector2.UP + Vector2.LEFT/3
		
	velocity = direction_vetor.normalized() * speed
	velocity = move_and_slide(velocity)
	
func out_of():
	if global_position.y < -300:
		queue_free()
		return true
	return false

func verify_res(res_input):
	if res_input == res:
		queue_free()
		return true
	else: return false
	
