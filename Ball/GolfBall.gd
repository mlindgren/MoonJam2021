extends RigidBody2D
signal hit

# Declare member variables here. Examples:
onready var _shotPowerLine = $ShotPowerLine
onready var _collisionShapeBall = $CollisionShapeBall

const MIN_VELOCITY : float = 15.0

var _charging: bool = false
var _ballHit: bool = false
var _ballInMotion: bool = false
var _initialClickPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	# Do nothing if ball is in motion
	if _ballInMotion:
		return
	

	if !_charging and (Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
		_charging = true
		_initialClickPos = get_viewport().get_mouse_position()
	
	if _charging:
		var chargeVector = _initialClickPos - get_viewport().get_mouse_position()
		_shotPowerLine.points[1] = chargeVector.rotated(self.rotation * -1)
		
		if !(Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
			_charging = false
			_shotPowerLine.points[1] = Vector2()
			
			self.apply_central_impulse(chargeVector)
			_ballHit = true
			Global.hitPoints -= 1
	
	get_viewport().get_viewport()
			 #var distance = _collisionShapeBall.position.distance_to(get_viewport().get_local_mouse_position())

		
func _isBallMoving():
	return _ballHit && self.linear_velocity.length() > MIN_VELOCITY
		
func _physics_process(_delta):
	_ballInMotion = self._isBallMoving()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
