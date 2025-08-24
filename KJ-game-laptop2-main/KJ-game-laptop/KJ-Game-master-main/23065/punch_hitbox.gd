extends CollisionShape2D

func _ready():
	#position = Vector2(-144.5, 76)
	pass
func _process(_delta_):
	#do m1s. the timer is for making it so that the punch hapnnes on the actual punch frame.
	if Rack.attacking == true:
		await get_tree().create_timer(0.15).timeout
		%punchhitbox.set_deferred("disabled", false)
	enablefordash()
	keepdisabled()
func keepdisabled():
	if  Rack.attacking == false and Rack.dashing == false:
		%punchhitbox.set_deferred("disabled", true)
	if Rack.combocooldown == true and Rack.dashing == false:
		%punchhitbox.set_deferred("disabled", true)
func enablefordash():
	if Rack.dashing == true:
		%punchhitbox.set_deferred("disabled", false)
		await get_tree().create_timer(0.1).timeout
