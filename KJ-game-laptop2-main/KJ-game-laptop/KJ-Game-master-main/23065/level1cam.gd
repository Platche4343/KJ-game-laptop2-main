extends Camera2D

var target_path = "/root/Scene/Rack"
var target_node : Node2D = null
var follow_speed = INF  # Adjust smoothing speed (higher = snappier)

func _ready():
	target_node = get_node_or_null(target_path)
	if target_node == null:
		print("❌ Could not find player at ", target_path)

func _process(delta):
	if target_node:
		# Smoothly move camera towards the player's position
		global_position = global_position.move_toward(target_node.global_position, follow_speed * delta)
