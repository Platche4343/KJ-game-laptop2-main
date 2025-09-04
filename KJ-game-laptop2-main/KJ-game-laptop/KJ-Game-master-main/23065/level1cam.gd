extends Camera2D

@export var randomstrength: float = 0.1
@export var shakefade: float = 1000.0
@export var isenabled: bool

var rng = RandomNumberGenerator.new()

var shakestrength: float = 0.0

func apply_shake():
	shakestrength = randomstrength

func _process(delta):
	if isenabled == true:
		apply_shake()
		
	if shakestrength > 0:
		shakestrength = lerpf(shakestrength,0,shakefade * delta)
		offset += randomoffset()
	else:
		offset = Vector2(0,0)
		isenabled = false		
	if target_node:
		
		# Smoothly move camera towards the player's position
		global_position = global_position.move_toward(target_node.global_position, follow_speed * delta)
func randomoffset():
	return Vector2(rng.randf_range(-shakestrength,shakestrength),rng.randf_range(-shakestrength,shakestrength))









var target_path = "/root/Scene/Rack"
var target_node : Node2D = null
var follow_speed = INF  # Adjust smoothing speed (higher = snappier)

var shake_intensity: float = 0.0
var active_shake_time: float = 0.0
var shake_decay: float = 5.0
var shake_time = 0.0
var shake_time_speed: float = 20.0
var noise = FastNoiseLite.new()

func _ready():
	target_node = get_node_or_null(target_path)
	if target_node == null:
		print(" Could not find player at ", target_path)
"""
func _physics_process(delta):
	if active_shake_time > 0:
		shake_time * delta * shake_time_speed
		active_shake_time -= delta
		
		position = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intensity,
			noise.get_noise_2d(0, shake_time) * shake_intensity
		)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)
	screen_shake(10,10)	
func screen_shake(intensity: int, time: float):
	randomize()
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0
func _process(delta):
	if target_node:
		
		# Smoothly move camera towards the player's position
		global_position = global_position.move_toward(target_node.global_position, follow_speed * delta)
"""
