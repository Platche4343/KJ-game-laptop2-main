extends Control


func _process(_delta):
	$HP.text = str(Global.Health)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
