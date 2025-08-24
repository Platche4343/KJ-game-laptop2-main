extends CharacterBody2D
@export var gravity = 2000
@onready var gethit = $GetHit
@onready var amazingman = get_tree().get_root().get_node(".")
@onready var parcel = load("res://parcel.tscn")
@export var ThrustY = -700
@export var ThrustX = 700
var spritescale = $".".scale
var direction = -1
var clearright = true
var clearleft = true
#var stunned : bool
#var knockedback: bool
func _ready() -> void:
	gethit.connect("amazingfreedom", Callable(self, "freedom"))
	$GetHit.connect("knockback", Callable(self, "on_knockback"))
	for child in get_children():
		if child.name.contains("GetHit"):
			var gethit = child.get_node("GetHit")
			
func freedom():
	queue_free()
func _physics_process(delta):
	# Add gravity every frame
	if Rack.dashing == true:
		
		set_collision_layer_value(1, true)
		await get_tree().create_timer(0.15).timeout
	elif Rack.dashing == false:
		set_collision_layer_value(1, false)
	
	
	velocity.y += gravity * delta
	move_and_slide()
func shoot():
	var instance = parcel.instantiate()

	# Set spawn position & rotation
	instance.global_position = global_position
	instance.rotation = rotation
	
	# ✅ VERY IMPORTANT: Set the target BEFORE adding to scene
	var player = get_node("/root/Scene/Rack")
	if player:
		instance.target_position = player.global_position
	else:
		print("Player not found!")
	
	# Optional: set speed
	instance.SPEED = 700

	# ✅ Add to scene AFTER setting target
	get_tree().get_root().call_deferred("add_child", instance)
	
func on_knockback():
	
	
	velocity.x = ThrustX * -direction
	velocity.y = ThrustY
	await get_tree().create_timer(0.1).timeout
	while not is_on_floor():
		await get_tree().create_timer(0.1).timeout
	velocity.x = 0
	gethit.amazinghealth -= 10
