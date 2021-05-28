extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var ShotPowerLine = $ShotPowerLine
onready var CollisionShapeBall = $CollisionShapeBall

var charging: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	#if charging:
	ShotPowerLine.points[1] = self.to_local(get_viewport().get_mouse_position())
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
