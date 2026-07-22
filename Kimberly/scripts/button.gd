extends Button

@export var main: Manager
@export var buttonIcon: Texture2D
@export var draggable: PackedScene

var isDragging: bool = false
var drag: Node
var cam: Camera3D
#
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = buttonIcon
	drag = draggable.instantiate()
	add_child(drag)
	drag.visible = false
	cam = get_viewport().get_camera_3d()
	
#func _physics_process(delta: float):
	#if isDragging:
		#var space_state = drag.get_world_3d().direct_space_state
		#var mouse_pos: Vector2 = get_viewport().get_mouse_position()
		#var origin: Vector3 = cam.project_ray_normal(mouse_pos)
		#var end: Vector3 = origin + cam.project_ray_normal(mouse_pos)
		#var query = PhysicsRayQueryParameters3D.create(origin, end)
		#query.collide_with_areas = true
		#var rayResult: Dictionary = space_state.intersect_ray(query)
		#if rayResult.size() > 0:
			#var co: CollisionObject3D = rayResult.get("collider")
			#drag.visible = true
			#drag.global_position = Vector3(co.global_position.x, 0.2, co.global_position.y)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_button_down() -> void:
	print("down")
	# isDragging = true
	
	main.set_flower(draggable)

#func _on_button_up() -> void:
	#print("up")
	#isDragging = false
