extends CharacterBody2D
@export var gravity = 2000
@onready var gethit = $GetHit
@onready var amazingman = get_tree().get_root().get_node(".")
@onready var parcel = load("res://parcel.tscn")
@export var thrust : Vector2
var spritescale = $".".scale
var direction = -1
var clearright = true
var clearleft = true
func _ready() -> void:
	gethit.connect("amazingfreedom", Callable(self, "freedom"))
func freedom():
	queue_free()
func _physics_process(delta):
	# Add gravity every frame
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
	instance.SPEED = 400.0

	# ✅ Add to scene AFTER setting target
	get_tree().get_root().call_deferred("add_child", instance)
