#@tool
extends Node3D

@export var gridWidth := 5:
	set(value):
		gridWidth = value
		#_remove_grid()
		#_create_grid()
@export var gridHeight := 5:
	set(value):
		gridHeight = value
		#_remove_grid()
		#_create_grid()
@export var cellSize: Vector2 = Vector2(1,1):
	set(value):
		cellSize = value
		#_remove_grid()
		#_create_grid()
@export var defaultcolor: Color = Color.GRAY

const GRIDCELL = preload("uid://bwnuoxwkba83s")

func _ready() -> void:
	_create_grid()

func _remove_grid():
	for node in get_children():
		node.queue_free()
		
func _create_grid():
	for height in range(gridHeight):
		for width in range(gridWidth):
			var gridCell = GRIDCELL.instantiate()
			gridCell.cellSize = cellSize
			
			add_child.call_deferred(gridCell)
			
			await gridCell.ready
			
			var offset = Vector3(width * cellSize.x, 0, height * cellSize.y)
			
			gridCell.global_position = global_position + offset
			gridCell.name = "Grid ("+str(height)+","+ str(width)+")"
			
