extends CanvasLayer

onready var _popup : Popup = $HoleFinishedPopup
onready var _label : Label = $HoleFinishedPopup/MessageLabel
onready var _winnerPopup : Popup = $WinnerPopup
onready var _hpTexture : TextureRect = $HPContainer/HPTexture

const HP_IMAGE_WIDTH = 112

const COMPLIMENTS = [
	"wow nice",
	"You're pretty good at handling balls",
	"ez",
	"AYAYA",
	"you did okay I guess",
	"Wow, you actually got it in"
]

const INSULTS = [
	"good job idiot =]",
	"Somebody's been spending too much time playing GTA RP",
	"git gud loser",
	"You golf worse than you drive",
	"Not even a real God Gamer",
	"old shit fat bald",
	"you suck lole",
	"Your imaginary wife is disappointed... as usual",
	"No wonder you never finished Vypur's game",
	"Bronze league skills",
	"Go back to Overwatch",
	"Don't quit your day job... oh, wait"
]

func get_random_insult():
	return INSULTS[randi() % INSULTS.size()]

func get_random_compliment():
	return COMPLIMENTS[randi() % COMPLIMENTS.size()]

var dead = false

func _on_NextHoleButton_pressed():
	# Ensure we're not paused if we were previously
	get_tree().paused = false
	
	if dead:
		if Global.game_mode == Global.GAME_MODE.GOD_GAMER:
			Global.currHole = 1
			Global.score = 0
			get_tree().change_scene("res://Courses/Hole1.tscn")
		else:
			get_tree().reload_current_scene()
			
	elif Global.currHole < Global.MAX_HOLE:
		Global.currHole += 1
		print("Changing to hole: " + String(Global.currHole))
		_popup.hide()
		get_tree().change_scene("res://Courses/Hole" + String(Global.currHole) + ".tscn")

func _on_GolfBall_ball_died():
	dead = true
	_label.text = get_random_insult()
	
	$HoleFinishedPopup/NextHoleButton/HBoxContainer/ButtonLabel.text = "Try Again"
	$HoleFinishedPopup/NextHoleButton/HBoxContainer/TextureRect.visible = false
	
	_popup.popup_centered()

func _on_GolfBall_ball_entered_hole():
	get_tree().paused = true
	
	_label.text = get_random_compliment()
	
	if Global.currHole < Global.MAX_HOLE:
		_popup.popup_centered()
	else:
		_winnerPopup.popup_centered()
