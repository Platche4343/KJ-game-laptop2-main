extends Area2D
var touching
signal goleft
signal stopleft
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Rack":
		touching = true
		emit_signal("goleft")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Rack":
		touching = false
		emit_signal("stopleft")
