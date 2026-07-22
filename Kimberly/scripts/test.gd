extends Node3D
class_name Manager
@onready var grid: Node3D = $grid
const CRESTED_LATE_SUMMER_MINT = preload("uid://bsxngfu374o5w")
const SPIDER_LILY = preload("uid://cynjdw2pvqkdj")

var object
#var isValid = false
var objectCells

func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("left_mouse_click") and not object:
		#var buildings = [CRESTED_LATE_SUMMER_MINT, SPIDER_LILY]
		##chooses building
		#var newPlacement = buildings.pick_random().instantiate()
		#add_child(newPlacement)
		#object = newPlacement
	if not object:
		return
		
		
	if Input.is_action_just_pressed("left_mouse_click"):
		_place_placement(objectCells)
		object = null

func set_flower(flower):
	var newPlacement = flower.instantiate()
	add_child(newPlacement)
	object = newPlacement

func _process(delta: float) -> void:
	if not object: return
	
	var mouseGridPosition = _get_grid_position()
	if mouseGridPosition:
		object.global_position = mouseGridPosition
		
		_reset_highlight()
		objectCells = _get_object_cells()
		#isValid = _check_and_highlight_cells(objectCells)
		#isValid = false


func _get_grid_position():
	var mousePositionDepth = 100
	var mousePosition := get_viewport().get_mouse_position()
	var currentCamera := get_viewport().get_camera_3d()
	var params := PhysicsRayQueryParameters3D.new()
	
	params.from = currentCamera.project_ray_origin(mousePosition)
	params.to = currentCamera.project_position(mousePosition, mousePositionDepth)
	params.collide_with_bodies = false
	params.collide_with_areas = true
	
	var worldspace := get_world_3d().direct_space_state
	var intersect := worldspace.intersect_ray(params)
	
	if not intersect: return
	
	if intersect.collider.get_parent().name == "grid":
		return intersect.collider.global_position
	else:
		return
		
func _reset_highlight():
	for child in grid.get_children():
		child.change_color(grid.defaultcolor)
		
func _get_object_cells():
	var cells = []
	
	for child in grid.get_children():
		if child.get_rect().intersects(object.get_rect()):
			cells.append(child)
			
	return cells
	
#func _check_and_highlight_cells(objectCells: Array):
	#var isValid = true
	#
	#var objectCellCoount = (object.get_rect().size.x / grid.cellSize.x) * (object.get_rect().size.y / grid.cellSize.y)
	#
	#if objectCellCoount != objectCells.size():
		#isValid = true
		#
	#for cell in objectCells:
		#if cell.full:
			#isValid = true
			#cell.change_color(Color.GREEN)
		#else:
			#cell.change_color(Color.GREEN)
			#
	#return isValid

func _place_placement(objectCells):
	object = null
	#isValid = null
	
	print(objectCells)
	for cell in objectCells:
		cell.full = true
		
	_reset_highlight()
