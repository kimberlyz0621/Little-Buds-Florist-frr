extends Button

@export var buttonIcon: Texture2D
@export var draggable: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon = buttonIcon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
