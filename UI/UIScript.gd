extends CanvasLayer

onready var _popup : Popup = $HoleFinishedPopup
onready var _winnerPopup : Popup = $WinnerPopup
onready var _hpTexture : TextureRect = $HPContainer/HPTexture

const HP_IMAGE_WIDTH = 112

func _process(_delta):
	
	if Global.hitPoints > 0:
		_hpTexture.rect_size.x = HP_IMAGE_WIDTH * Global.hitPoints
	else:
		# Setting width to 0 doesn't work
		_hpTexture.hide()

func _on_NextHoleButton_pressed():
	# Ensure we're not paused if we were previously
	get_tree().paused = false
	
	Global.ballInHole = false
	if Global.currHole <= Global.MAX_HOLE:
		print("Changing to hole: " + String(Global.currHole))
		_popup.hide()
		get_tree().change_scene("res://Courses/Hole" + String(Global.currHole) + ".tscn")
	else:
		print("A winner is you")

func _on_GolfBall_ball_died():
	_popup.popup_centered()

func _on_GolfBall_ball_entered_hole():
	get_tree().paused = true
	
	print("HOLE ENTERED LOL")
	if Global.currHole < Global.MAX_HOLE && !Global.ballInHole:
		Global.ballInHole = true
		Global.currHole += 1
		Global.hitPoints += 1
		_popup.popup_centered()
	else:
		_winnerPopup.popup_centered()
