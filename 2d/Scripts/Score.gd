extends Label

func _process(delta):
	text = "000" + str(Global.fruits)
	if Global.fruits >= 10:
		text = "00" + str(Global.fruits)
	elif Global.fruits >= 100:
		text = "0" + str(Global.fruits)
