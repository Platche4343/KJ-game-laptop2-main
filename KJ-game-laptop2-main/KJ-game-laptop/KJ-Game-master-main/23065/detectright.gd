extends Area2D
var touching
signal goright
signal stopright
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Rack":
		touching = true
		emit_signal("goright")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Rack":
		touching = false
		emit_signal("stopright")
