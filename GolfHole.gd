extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var _popup = get_node("/root/Hole" + String(Global.currHole) + "/HoleFinishedPopup")
onready var _ball = get_node("/root/Hole" + String(Global.currHole) + "/GolfBall")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_GolfHole_body_entered(body):
	print("HOLE ENTERED LOL")
	#_ball.hide()
	_popup.popup_centered()
