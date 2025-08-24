extends Area2D
signal relayfreedom
signal knockbackrack
var Touching = false
var oncooldown = false
@onready var parent = get_parent()
func Cooldown(time):
	oncooldown = true
	await get_tree().create_timer(time).timeout
	oncooldown = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Rack":
		Touching = true
	
		print("I GOT HIT")
		print(Global.Health)
	


func _on_body_exited(body):
	if body.name == "Rack":
		Touching = false


func _process(_delta):
	if parent.stunned == false:
		if Touching == true and oncooldown == false and parent.stunned == false:
			await get_tree().create_timer(0.6).timeout
			if Touching == true and oncooldown == false and parent.stunned == false:
				Global.Health -= 16
				emit_signal("knockbackrack")
				#print(Global.Health)
			oncooldown = true
			await get_tree().create_timer(0.6).timeout
			oncooldown = false
		elif Touching == true and oncooldown == true:
			parent.attacking = true
		else:
			parent.attacking = false
	if Global.Health <= 0:
		Touching = false
	#print(parent.stunned)
func _ready():
	$gethit.connect("freedom", Callable(self, "_on_freedom"))
	get_node("../detectright").connect("goright", Callable(self, "go_right"))
	get_node("../detectleft").connect("goleft", Callable(self, "go_left"))
func _on_freedom():
	
	queue_free()
	emit_signal("relayfreedom")

func go_right():
	scale.x = 1
func go_left():
	scale.x = -1
