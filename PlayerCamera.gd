extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _ball = get_node("/root/Hole" + String(Global.currHole) + "/GolfBall")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


 # Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position = _ball.position
