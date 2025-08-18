extends Area2D
#Kills the player when touched.
func _on_body_entered(body: Node2D) -> void:
	print(self.name)
	if body.name == "Rack":
		%Rack.position.x = Global.CheckpointX
		%Rack.position.y = Global.CheckpointY
		Global.Health = 100
#kills the player when health is equal to or less than zero.
func _process(_delta):
	if Global.Health == 0 or Global.Health <= 0:
		%Rack.position.x = Global.CheckpointX
		%Rack.position.y = Global.CheckpointY
		Global.Health = 100
		await get_tree().create_timer(2).timeout
