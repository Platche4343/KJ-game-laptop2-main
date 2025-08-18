extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print(self.name)
	if body.name == "Rack":
		Global.CheckpointX = global_position.x
		Global.CheckpointY = global_position.y
