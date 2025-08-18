extends Sprite2D
@onready var right = get_node_or_null("../detectrightA")
@onready var left = get_node_or_null("../detectleftA")
var direction
func _ready():
	await get_tree().process_frame # Wait one frame
	right.body_entered.connect(_on_body_enteredright)
	right.body_exited.connect(_on_body_exitedright)
	left.body_entered.connect(_on_body_enteredleft)
	left.body_exited.connect(_on_body_exitedleft)
	
func _on_body_enteredright(body: Node2D) -> void:
	if body.name == "Rack":
		transform.x.x = 0.5
		direction = 1
		while direction == 1:
			await get_tree().create_timer(3).timeout
			triggerthrow()
			await get_tree().create_timer(5).timeout
			if direction != 1:
				break
		#$BlueManThingGuyNotTranslparent.flip_h = flip_h
func _on_body_exitedright(body: Node2D) -> void:
	direction = 0
func _on_body_enteredleft(body: Node2D) -> void:
	if body.name == "Rack":
		transform.x.x = -0.5
		direction = -1
		while direction == -1:
			await get_tree().create_timer(3).timeout
			triggerthrow()
			await get_tree().create_timer(5).timeout
			if direction != -1:
				break
		#$BlueManThingGuyNotTranslparent.flip_h = flip_h
func _on_body_exitedleft(body: Node2D) -> void:
	direction = 0
func triggerthrow():
	$"..".shoot()
