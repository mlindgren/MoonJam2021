class_name GolfBall
extends RigidBody2D

signal ball_hit
signal ball_died
signal ball_entered_hole

# Declare member variables here. Examples:
onready var _shotPowerLine = $ShotPowerLine
onready var _sprite = $Sprite
onready var _tween = $Tween

const MIN_VELOCITY : float = 15.0
const MAX_CHARGE_VECTOR_LENGTH = 300.0
const POWER_SCALING_FACTOR : float = 5.0
const KILLBOX_COLLISION_LAYER : int = 4

# Constants for hole entry animation
const MAX_HOLE_ENTRY_VELOCITY : float = 500.0
const HOLE_ENTRY_DURATION : float = 0.25

var charging: bool = false

# Counts how many slopes the ball has entered. I initially used a bool for this
# to track whether the ball was on a slope, but when two slope areas are directly
# adjacent, the ball can enter a second slope before it exits the first one, and
# then when the first one is exited, the bool would be set to false even though
# the ball is still on a slope. So instead we count how many slopes we've entered
# and if it's >0 we're on a slope. I don't think signals are multithreaded so
# this should work fine.
var slopeCount: int = 0

var _chargeVector: Vector2
var _ballHit: bool = false
var _ballInMotion: bool = false
var _initialClickPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _isBallMoving():
	return _ballHit && linear_velocity.length() > MIN_VELOCITY
		
func _physics_process(_delta):
		
	if slopeCount == 0 and linear_velocity.length() < MIN_VELOCITY:
		linear_velocity = Vector2()
		
	_ballInMotion = _isBallMoving()
	
	_sprite.material.set_shader_param(
		"Position",
		position / _sprite.region_rect.size * -1);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if charging:
		_chargeVector =  (_initialClickPos - get_viewport().get_mouse_position()).clamped(
			MAX_CHARGE_VECTOR_LENGTH)
		_shotPowerLine.points[1] = _chargeVector.rotated(rotation * -1)
		
		if !(Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
			charging = false
			_shotPowerLine.points[1] = Vector2()
			
			apply_central_impulse(_chargeVector * POWER_SCALING_FACTOR)
			_ballHit = true
			Global.score += 1
			emit_signal("ball_hit")

func _on_GolfBall_input_event(viewport, event, _shape_idx):
	# Do nothing if ball is in motion
	if _ballInMotion:
		return
	
	if !charging and (Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
		charging = true
		_initialClickPos = viewport.get_mouse_position()
		get_tree().set_input_as_handled()

func _on_GolfBall_body_entered(body):
	print(body, " ", body.collision_layer)
	if body.collision_layer & KILLBOX_COLLISION_LAYER:
		get_tree().paused = true
		emit_signal("ball_died")

func _on_GolfHole_body_entered(body):
	print("Hole entered at velocity ", linear_velocity.length())
	if linear_velocity.length() < MAX_HOLE_ENTRY_VELOCITY:
		_tween.interpolate_property(
			self,
			"scale",
			scale,
			Vector2(),
			HOLE_ENTRY_DURATION,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN)
		_tween.interpolate_property(
			self,
			"linear_velocity",
			linear_velocity,
			Vector2(),
			HOLE_ENTRY_DURATION,
			Tween.TRANS_LINEAR,
			Tween.EASE_IN)
		_tween.interpolate_callback(
			self,
			HOLE_ENTRY_DURATION,
			"emit_signal",
			"ball_entered_hole")
		_tween.start()


func _on_GolfBall_ball_died():
	pass # Replace with function body.
