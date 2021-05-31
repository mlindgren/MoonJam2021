extends KinematicBody2D

export var degrees_per_sec : float = 5

func _physics_process(delta):
	rotation += degrees_per_sec * delta
