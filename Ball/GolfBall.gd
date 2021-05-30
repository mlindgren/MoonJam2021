extends RigidBody2D

signal ball_hit

# Declare member variables here. Examples:
onready var _shotPowerLine = $ShotPowerLine
onready var _collisionShapeBall = $CollisionShapeBall
onready var _sprite = $Sprite

const MIN_VELOCITY : float = 15.0
const MAX_CHARGE_VECTOR_LENGTH = 300.0
const POWER_SCALING_FACTOR : float = 5.0

var charging: bool = false

var _chargeVector: Vector2
var _ballHit: bool = false
var _ballInMotion: bool = false
var _initialClickPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _isBallMoving():
	return _ballHit && self.linear_velocity.length() > MIN_VELOCITY
		
func _physics_process(_delta):
	_ballInMotion = self._isBallMoving()
	
	# _sprite.material.set_shader_param("Direction", self.linear_velocity.normalized())
	# _sprite.material.set_shader_param("Speed", self.linear_velocity.length())
	_sprite.material.set_shader_param(
		"Position",
		self.position / _sprite.region_rect.size * -1);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if charging:
		_chargeVector =  (_initialClickPos - get_viewport().get_mouse_position()).clamped(
			MAX_CHARGE_VECTOR_LENGTH)
		_shotPowerLine.points[1] = _chargeVector.rotated(self.rotation * -1)
		
		if !(Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
			charging = false
			_shotPowerLine.points[1] = Vector2()
			
			self.apply_central_impulse(_chargeVector * POWER_SCALING_FACTOR)
			_ballHit = true
			emit_signal("ball_hit")

func _on_GolfBall_input_event(viewport, event, _shape_idx):
	# Do nothing if ball is in motion
	if _ballInMotion:
		return
	
	if !charging and (Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
		charging = true
		_initialClickPos = viewport.get_mouse_position()
		get_tree().set_input_as_handled()

