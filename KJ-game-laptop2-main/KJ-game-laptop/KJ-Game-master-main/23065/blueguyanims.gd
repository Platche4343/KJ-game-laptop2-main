extends AnimatedSprite2D
var current_anim = ""
var locked_until_finished = false
@onready var parent = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if parent.velocity.x != 0 and parent.stunned == false:
		play_animation("run", false)
	else: 
		play_animation("idle", false)
func play_animation(name: String, lock := false):
	if current_anim == name:
		return  # don't restart the same animation every frame
	current_anim = name
	$".".play(name)
	locked_until_finished = lock
