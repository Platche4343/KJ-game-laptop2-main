extends CollisionShape2D

func _ready():
	position = Vector2(-144.5, 76)
func _process(_delta_):
	if  Rack.attacking == false and Rack.dashing == false:
		%punchhitbox.set_deferred("disabled", true)
	elif Rack.attacking == true or Rack.dashing == true:
		%punchhitbox.set_deferred("disabled", false)
	if Rack.combocooldown == true and Rack.dashing == false:
		%punchhitbox.set_deferred("disabled", true)
