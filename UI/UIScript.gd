extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _popup : Popup = $CanvasLayer/HoleFinishedPopup
onready var _winnerPopup : Popup = $CanvasLayer/WinnerPopup
onready var _camera : Camera2D = $"/root/Course/GolfBall/BallCam"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/HPContainer/Background/HPCount.text = String(Global.hitPoints)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CanvasLayer/HPContainer/Background/HPCount.text = String(Global.hitPoints)

func _on_NextHoleButton_pressed():
	Global.ballInHole = false
	if Global.currHole <= Global.MAX_HOLE:
		print("Changing to hole: " + String(Global.currHole))
		get_tree().change_scene("res://Courses/Hole" + String(Global.currHole) + ".tscn")
	else:
		print("A winner is you")

func _on_GolfHole_body_entered(body):
	print("HOLE ENTERED LOL")
	if Global.currHole < Global.MAX_HOLE && !Global.ballInHole:
		Global.ballInHole = true
		Global.currHole += 1
		Global.hitPoints += 1
		_popup.popup_centered()
	else:
		_winnerPopup.popup_centered()
