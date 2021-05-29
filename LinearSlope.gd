extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _area = $SlopeArea

# Called when the node enters the scene tree for the first time.
func _ready():
	_area.gravity_vec = _area.gravity_vec.rotated(self.rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
