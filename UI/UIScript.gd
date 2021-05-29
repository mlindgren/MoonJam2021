extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _popup : Popup = $CanvasLayer/HoleFinishedPopup
onready var _camera : Camera2D = $"/root/Course/GolfBall/BallCam"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_NextHoleButton_pressed():
	if Global.currHole < Global.MAX_HOLE:
		Global.currHole += 1
		print("Changing to hole: " + String(Global.currHole))
		get_tree().change_scene("res://Courses/Hole" + String(Global.currHole) + ".tscn")
	else:
		print("A winner is you")

func _on_GolfHole_body_entered(body):
	print("HOLE ENTERED LOL")
	#_ball.hide()
	_popup.popup_centered()
