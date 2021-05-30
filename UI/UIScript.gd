extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var _popup : Popup = $CanvasLayer/HoleFinishedPopup
onready var _winnerPopup : Popup = $CanvasLayer/WinnerPopup
onready var _hpTexture : TextureRect = $CanvasLayer/HPContainer/HPTexture

const HP_IMAGE_WIDTH = 112

func _process(_delta):
	
	if Global.hitPoints > 0:
		_hpTexture.rect_size.x = HP_IMAGE_WIDTH * Global.hitPoints
	else:
		# Setting width to 0 doesn't work
		_hpTexture.hide()

func _on_NextHoleButton_pressed():
	Global.ballInHole = false
	if Global.currHole <= Global.MAX_HOLE:
		print("Changing to hole: " + String(Global.currHole))
		_popup.hide()
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
