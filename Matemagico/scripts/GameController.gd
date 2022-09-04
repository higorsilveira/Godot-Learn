extends Node2D

var algarismo = [0,0]
var index = 0
var enemy = preload("res://EnemyGroup.tscn")
var group = [preload("res://EnemyGroup.tscn")]
var particle = preload("res://particle/Particle.tscn").instance()
var target = Vector2()
var vel = Vector2()

func _ready():
	group.clear()
	$Player.add_child(particle)

func _process(_delta):
	$Resultado.text = str(algarismo[0])+str(algarismo[1])
	
#func move_particle():
#	vel = particle.global_position.direction_to(target) * 200
##	particle.look_at(target)
#	if particle.global_position.distance_to(target) > 5:
#		vel = particle.move_and_slide(vel)
#		target = Vector2()

func _on_Timer_timeout():
	randomize()
	var enemies = [enemy]
	var type = enemies[randi() % enemies.size()]
	var ene = type.instance()
	ene.global_position = Vector2(rand_range(-100,150),0)
	$Spawn.add_child(ene)
	group.append(ene)
	for en in group:
		if en.out_of():
			group.erase(en)
	$Timer.wait_time = rand_range(1,3)
	
func _on_Send_button_down():
	print(group)
	for en in group:
		if en.verify_res(int($Resultado.text)):
			group.erase(en)
	algarismo[0] = 0
	algarismo[1] = 0
	index = 0

func _on_Button_button_down():
	algarismo.remove(0)
	algarismo.append("-")
	
func _on_Button1_button_down():
	algarismo.remove(0)
	algarismo.append(1)

func _on_Button2_button_down():
	algarismo.remove(0)
	algarismo.append(2)

func _on_Button3_button_down():
	algarismo.remove(0)
	algarismo.append(3)

func _on_Button4_button_down():
	algarismo.remove(0)
	algarismo.append(4)

func _on_Button5_button_down():
	algarismo.remove(0)
	algarismo.append(5)

func _on_Button6_button_down():
	algarismo.remove(0)
	algarismo.append(6)

func _on_Button7_button_down():
	algarismo.remove(0)
	algarismo.append(7)

func _on_Button8_button_down():
	algarismo.remove(0)
	algarismo.append(8)

func _on_Button9_button_down():
	algarismo.remove(0)
	algarismo.append(9)

func _on_Button0_button_down():
	algarismo.remove(0)
	algarismo.append(0)
