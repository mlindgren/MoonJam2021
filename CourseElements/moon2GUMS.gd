extends Path2D

export var speed : float = 250.0

onready var pathFollow = $PathFollow2D
onready var kineticBody = $PathFollow2D/KineticBody

var _lastPos : Vector2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pathFollow.offset += speed * delta

	# Flip our sprite based on the direction we're travelling
	if _lastPos.x > pathFollow.position.x:
		# Moving left
		kineticBody.scale.x = 1
	else:
		kineticBody.scale.x = -1
		
	_lastPos = pathFollow.position
