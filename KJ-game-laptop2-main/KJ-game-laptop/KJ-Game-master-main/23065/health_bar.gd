extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_frame(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	healthdeduction(Global.Health)

func healthdeduction(health):
	if Global.Health <= health:
		var frameno = Global.Health / 4 
		set_frame(frameno)
		print(frameno)
