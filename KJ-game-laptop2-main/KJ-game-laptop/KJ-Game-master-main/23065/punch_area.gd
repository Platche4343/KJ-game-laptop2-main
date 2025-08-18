extends Area2D
func _ready():
	monitoring = true
	monitorable = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("_on_special_area_entered"):
		area._on_special_area_entered(self)


func _on_area_exited(_area: Area2D) -> void:
	pass
