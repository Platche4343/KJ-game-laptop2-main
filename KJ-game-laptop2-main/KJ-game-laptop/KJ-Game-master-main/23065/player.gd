extends CharacterBody2D

signal playanimation

@export var speed = 150
@export var dash = 2850
@export var jump_speed = -1000
@export var gravity = 2000
@export var ThrustY = -700
@export var ThrustX = 700

@onready var parent = get_parent()

var stunned = false

var knockedback: = false

var movingX 

var axisondemand : float

var activatejump

var dashaxis

var jumping = false

var rackonfloor

var dashcooldown = false

var sprinting = false

var attacking = false

var combo = 0

var combocooldown = false

var m1cooldown = false

var dashing = false

var airtime: float
func _ready():
	
	for child in parent.get_children():
		if child.name.begins_with("Blue Guy") and child.has_node("attackbox"):
			var box = child.get_node("attackbox")
			box.connect("knockbackrack", Callable(self, "on_knockback"))

func comboreset():
	if Input.is_action_just_pressed("Space") and sprinting == false:
		
		if combo == 1:
			await get_tree().create_timer(1).timeout
			if combo == 1:
				combo = 0
				
				attacking = false
				
		elif combo == 2:
			await get_tree().create_timer(1).timeout
			if combo == 2:
				combo = 0
				
				attacking = false
				
		elif combo == 3:
			await get_tree().create_timer(1).timeout
			if combo == 3:
				combo = 0
				
				attacking = false
				
		else:
			pass
	

func _physics_process(delta):
	# Add gravity every frame
	
	if not is_on_floor() and dashing == false:
		velocity.y += gravity * delta
		rackonfloor = false
		
	else: 
		rackonfloor = true
		
	if knockedback == false and stunned == false:	
		if Input.is_action_pressed("Shift") and dashing == false:
			sprinting = true
		
			speed = 620
			velocity.x = Input.get_axis("walk_left", "walk_right") * speed
		elif not Input.is_action_pressed("Shift") and dashing == false:
			sprinting = false
		
			speed = 300
			velocity.x = Input.get_axis("walk_left", "walk_right") * speed
		
		if dashing == true:
		
			velocity.x = dashaxis * dash
			velocity.y = 0
		
		if sprinting and Input.is_action_just_pressed("Space") and dashcooldown == false:
			axisondemand = Input.get_axis("walk_left", "walk_right")
			dashing = true
			await dodash()
		
		if Input.is_action_pressed("jump") and is_on_floor() and dashing == false:
			velocity.y = jump_speed
			activatejump = true
	
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			if Input.get_axis("walk_left", "walk_right") != 0:
							dashaxis = Input.get_axis("walk_left", "walk_right")
							transform.x.x =  Input.get_axis("walk_left", "walk_right") * -1
						
		elif Input.is_action_pressed("walk_left") and Input.is_action_pressed("walk_right"):
			pass
	
	move_and_slide()
	#print("floor-check:",is_on_floor(),"velocity:",velocity)

func jumpcheck():
	if activatejump == true:
		activatejump = false
		jumping = true
		
		await get_tree().create_timer(0.2).timeout
		jumping = false


func updatepos():
	Rack.rackposition = $".".position
	if velocity.x != 0:
		movingX = true
	else:
		movingX = false
func Cooldown(time):
	dashcooldown = true
	await get_tree().create_timer(time).timeout
	dashcooldown = false

func dodash():
	dashing = true
	combo = 5
	m1cooldown = false
	combocooldown = false
	await get_tree().create_timer(0.15).timeout
	dashing = false
	combo = 0
	await Cooldown(1)
func attack():
	
	if Input.is_action_just_pressed("Space") and sprinting == false and combocooldown == false and m1cooldown == false and knockedback == false and stunned == false:
		
		if combo == 0:
			
			combo = 1
		elif combo == 1:
			
			combo = 2
		elif combo == 2:
			
			combo = 3
		elif combo == 3:
			
			combo = 4
		elif combo == 4:
			combo = 0
			combocooldown = true
			
			await get_tree().create_timer(0.6).timeout
			combocooldown = false
			
		print(combo)
	if Input.is_action_just_pressed("Space") and sprinting == false and combocooldown == false and m1cooldown == false:
		
		attacking = true
		await get_tree().process_frame
		m1cooldown = true
		await get_tree().create_timer(0.2).timeout
		attacking = false
		
		
		await get_tree().create_timer(0.05).timeout
		m1cooldown = false

func on_knockback():
	stunned = true
	knockedback = true
	velocity.x = ThrustX * transform.x.x
	velocity.y = ThrustY
	await get_tree().create_timer(0.1).timeout
	while not is_on_floor():
		await get_tree().create_timer(0.1).timeout
		knockedback = true
		stunned = true
	knockedback = false
	stunned = false

func UpdateVars():
	Rack.attacking = attacking
	Rack.combo = combo
	Rack.combocooldown = combocooldown
	Rack.dashcooldown = dashcooldown
	Rack.jumping = jumping
	Rack.m1cooldown = m1cooldown
	Rack.sprinting = sprinting
	Rack.rackonfloor = rackonfloor
	Rack.movingX = movingX
	Rack.dashing = dashing
	
func  _process(_delta):
	attack()
	comboreset()
	jumpcheck()
	updatepos()
	UpdateVars()
	jumphightcheck()
func jumphightcheck():
	if velocity.y == 0 and rackonfloor == false:
		print(airtime) 
	elif rackonfloor == true:
		airtime = 0
	else:
		await get_tree().create_timer(0.001).timeout
		airtime += 0.001
