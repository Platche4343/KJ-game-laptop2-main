"""extends AnimatedSprite2D

func _ready():
	%Animations.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _process(_delta):
	if Input.is_action_just_pressed("jump"):
		%Animations.play("jump")
		
	if Rack.rackonfloor == true:
		if Rack.jumping == false:
			if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
				if Rack.sprinting == false and Rack.attacking == false:
					%Animations.play("walk")
				if Rack.sprinting == true:
					%Animations.play("run")
			else:
					%Animations.play("idle")
	if Rack.attacking == true:
		if Rack.combo == 1:
			%Animations.play("m1-1")"""
extends AnimatedSprite2D

var current_anim = ""
var locked_until_finished = false

func _ready():
	%Animations.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _process(_delta):
	if locked_until_finished:
		return  # block animation changes while a one-shot animation is playing
	
	
	
	if Input.is_action_pressed("jump") and Rack.rackonfloor:
		play_animation("jump", true)
	
	
	elif Rack.attacking == true:
		if Rack.combo == 1:
			play_animation("m1-1", true)
		if Rack.combo == 2:
			play_animation("m1-2", true)
		if Rack.combo == 3:
			play_animation("m1-3", true)
		if Rack.combo == 4:
			play_animation("m1-4", true)
	elif Rack.rackonfloor:
		if not Rack.jumping or Rack.rackonfloor:
			if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
				if Rack.sprinting and Rack.movingX == true:
					play_animation("run", false)
				elif not Rack.attacking and Rack.movingX == true:
					play_animation("walk", false)
				elif Rack.movingX == false and Rack.rackonfloor == true:
					play_animation("idle", false)
			else:
				play_animation("idle")
	elif not Rack.rackonfloor:
		play_animation("fall", false)		
	
	if Rack.sprinting == true and Input.is_action_just_pressed("Space"):
		if Rack.dashcooldown == false:
			play_animation("dash", true)
					
		
func play_animation(name: String, lock := false):
	if current_anim == name:
		return  # don't restart the same animation every frame
	current_anim = name
	%Animations.play(name)
	locked_until_finished = lock

func _on_animation_finished():
	locked_until_finished = false
