extends CharacterBody2D

var SPEED = 1500.0
var dir
var target_position : Vector2

@onready var target = get_node("/root/Rack")

func _ready():
	$Area2D.connect("explode", Callable(self, "explod"))
	print("Projectile spawned at: ", global_position)
	print("Target position at spawn time: ", target_position)
	dir = (target_position - global_position).normalized()
	await get_tree().create_timer(10).timeout
	queue_free()
	
	look_at(target_position)
func _physics_process(delta):
	var movement = dir * SPEED * delta
	global_position += movement
	rotation -= 0.1

func explod():
	queue_free()
