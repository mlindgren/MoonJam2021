extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.gravity_vec = self.gravity_vec.rotated(self.rotation)
