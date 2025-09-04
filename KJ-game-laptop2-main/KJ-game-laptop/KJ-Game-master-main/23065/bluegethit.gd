extends Area2D

signal freedom
signal knockback
var combochecker 
var Bluehealth = 120
var last_notifier: Area2D = null
@onready var parent = get_parent().get_parent()
@onready var hitburst = load("res://m1 burst.tscn")
func _on_body_entered(body):
	pass
	#print("hit")
	#if body.name == "Rack" and Rack.attacking == true:
	#	Bluehealth -=25
	#	print(Bluehealth)

func _on_special_area_entered(by_area: Area2D) -> void:
	last_notifier = by_area
	camera.isenabled = true
	var instance = hitburst.instantiate()
	instance.transform.x.x = -parent.direction
	instance.global_position.x = global_position.x + 40 * parent.direction
	instance.global_position.y = global_position.y
	get_tree().get_root().call_deferred("add_child", instance)
	
		#print("I entered ", by_area.name)
	if Rack.combo == 1:
		Bluehealth -=10
		bursteffect()
	elif Rack.combo == 2:
		Bluehealth -= 10
		bursteffect()
	elif Rack.combo == 3:
		Bluehealth -= 10
		bursteffect()
	elif Rack.combo == 4:
		Bluehealth -= 20
		bursteffect()
		emit_signal("knockback")
	elif Rack.combo == 5:
		Bluehealth -= 10
		bursteffect()
	if Rack.combo < 4:
		parent.stunned = true
	combochecker = Rack.combo
	await get_tree().create_timer(1).timeout
	if combochecker < Rack.combo or Rack.combo == 0:
		parent.stunned = false
	camera.isenabled = false
	
		

	print("BLUE", Bluehealth)
func _process(_delta):
	if Bluehealth <= 0:
		print("blue die")
		emit_signal("freedom")
		
		free()
func stuntimer(time):
	pass
func bursteffect():
	$"../../BlueManThingGuyNotTranslparent/burst".emitting = true
