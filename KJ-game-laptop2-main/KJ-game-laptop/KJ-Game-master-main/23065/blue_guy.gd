extends CharacterBody2D
@export var gravity = 2000
@export var speed = 400
@export var ThrustY = -700
@export var ThrustX = 700
@onready var detectleft = $detectleft
@onready var detectright = $detectright

var attacking = false
var direction = 0
var stunned : bool
var knockedback: bool
func _ready():
	$attackbox.connect("relayfreedom", Callable(self, "_on_relay_freedom"))
	$detectright.connect("goright", Callable(self, "go_right"))
	$detectleft.connect("goleft", Callable(self, "go_left"))
	$detectright.connect("stopright", Callable(self, "stop_right"))
	$detectleft.connect("stopleft", Callable(self, "stop_left"))
	$attackbox/gethit.connect("knockback", Callable(self, "on_knockback"))
	$BlueManThingGuyNotTranslparent.play("idle")
func _on_relay_freedom():
	queue_free()
func go_right():
	direction = 1
	$BlueManThingGuyNotTranslparent.transform.x.x = 0.8
func go_left():
	direction = -1
	$BlueManThingGuyNotTranslparent.transform.x.x = -0.8
func stop_right():
	direction = 0
	
func stop_left():
	direction = 0
	
func _physics_process(delta):
	# Add gravity every frame
	if stunned == false and knockedback == false:
		if direction == 1 and not attacking and $attackbox.Touching == false:
			velocity.x = speed 
		elif direction == -1 and not attacking and $attackbox.Touching == false:
			velocity.x = speed * -1
		
		else:
			velocity.x = 0
	elif stunned == true:
		velocity.x = 0
	
	if Rack.dashing == true:
		#stunned = true
		set_collision_layer_value(1, true)
		await get_tree().create_timer(0.15).timeout
	elif Rack.dashing == false and $attackbox.Touching == false:
		set_collision_layer_value(1, false)		
	velocity.y += gravity * delta
	move_and_slide()

func on_knockback():
	stunned = false
	knockedback = true
	velocity.x = ThrustX * -direction
	velocity.y = ThrustY
	await get_tree().create_timer(0.1).timeout
	while not is_on_floor():
		await get_tree().create_timer(0.1).timeout
		knockedback = true
		stunned = false
	velocity.x = 0
	knockedback = true
	stunned = true
	#$BlueManThingGuyNotTranslparent.play("getup")
	await get_tree().create_timer(1).timeout
	stunned = false
	knockedback = false
	

func stuntimer(time):
	await get_tree().create_timer(time).timeout
	stunned = false
