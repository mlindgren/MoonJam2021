# Smooth camera zoom code from https://www.gdquest.com/tutorial/godot/2d/camera-zoom/
extends Camera2D

var _following_ball : bool = false

# Lower cap for the `_zoom_level`.
export var min_zoom := 0.5
# Upper cap for the `_zoom_level`.
export var max_zoom := 2.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
export var zoom_factor := 0.1
# Duration of the zoom's tween animation.
export var zoom_duration := 0.2

export var tween_follow_duration := 0.2

# The camera's target zoom level.
var _zoom_level := 1.5 setget _set_zoom_level

# Camera boundary
export var boundary_upper_left := Vector2(-1065, -2000)
export var boundary_lower_right := Vector2(848, 469)

onready var tween: Tween = $Tween
onready var ball: RigidBody2D = $"/root/Course/GolfBall"

func _set_zoom_level(value: float) -> void:
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	tween.interpolate_property(
		self,
		"zoom",
		zoom,
		Vector2(_zoom_level, _zoom_level),
		zoom_duration,
		Tween.TRANS_SINE,
		# Easing out means we start fast and slow down as we reach the target value.
		Tween.EASE_OUT
	)
	tween.start()

func _process(delta):
	if _following_ball:
		tween.interpolate_property(
			self,
			"position",
			position,
			ball.position,
			tween_follow_duration,
			Tween.TRANS_SINE,
			Tween.EASE_OUT)

func _unhandled_input(event):
	
	var handled : bool = false
	
	# Allow the player to drag the camera only if they're not charging up a shot
	if ball and !ball.charging and \
		event is InputEventMouseMotion and \
		(Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
		
		_following_ball = false
		tween.stop(self, "position")
		
		position -= event.relative
		position.x = clamp(position.x, boundary_upper_left.x, boundary_lower_right.x)
		position.y = clamp(position.y, boundary_upper_left.y, boundary_lower_right.y)
		
		handled = true
	
	if event.is_action_pressed("zoom_in"):
		# Inside a given class, we need to either write `self._zoom_level = ...` or explicitly
		# call the setter function to use it.
		_set_zoom_level(_zoom_level - zoom_factor)
		handled = true
	elif event.is_action_pressed("zoom_out"):
		_set_zoom_level(_zoom_level + zoom_factor)
		handled = true
		
	if handled:
		get_tree().set_input_as_handled()

func _on_GolfBall_ball_hit():
	_following_ball = true
	if ball:
		tween.interpolate_property(
			self,
			"position",
			position,
			ball.position,
			tween_follow_duration,
			Tween.TRANS_SINE,
			Tween.EASE_OUT)
		tween.start()
	
