extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ShotPowerLine = $ShotPowerLine
onready var CollisionShapeBall = $CollisionShapeBall

var Charging: bool = false
var InitialClickPos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	#if charging:
	if !Charging and (Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
		Charging = true
		InitialClickPos = get_viewport().get_mouse_position()
	
	if Charging:
		var chargeVector = InitialClickPos - get_viewport().get_mouse_position()
		ShotPowerLine.points[1] = chargeVector
		
		if !(Input.get_mouse_button_mask() & BUTTON_MASK_LEFT):
			Charging = false
			ShotPowerLine.points[1] = Vector2()
			
			self.apply_central_impulse(chargeVector)
			
		 #var distance = CollisionShapeBall.position.distance_to(get_viewport().get_local_mouse_position())
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#func _on_GolfBall_input_event(viewport, event, shape_idx):
#	print("Input event")
#	if event is InputEventMouseButton:
#		print("Input event at ", event.position)
#		ShotPowerLine.points[1] = event.position
#		ShotPowerLine.update()
