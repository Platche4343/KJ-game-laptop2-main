extends Area2D
signal amazingfreedom
signal knockback
var amazinghealth = 70
var last_notifier: Area2D = null
func _on_body_entered(body):

	if body.name == "Rack" and Rack.attacking == true:
		amazinghealth -=25
		print(amazinghealth)

func _on_special_area_entered(by_area: Area2D) -> void:
	last_notifier = by_area
	#print("I entered ", by_area.name)
	if Rack.combo == 1:
		amazinghealth -=10
	elif Rack.combo == 2:
		amazinghealth -= 10
	elif Rack.combo == 3:
		amazinghealth -= 10
	elif Rack.combo == 4:
		amazinghealth -= 20
		emit_signal("knockback")
	elif Rack.combo == 5:
		amazinghealth -= 10
		

	print("amazing", amazinghealth)
	
func _process(_delta):
	if amazinghealth <= 0:
		print("amazing die")
		emit_signal("amazingfreedom")
