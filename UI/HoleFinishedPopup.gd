extends PopupDialog

var COMPLIMENTS = ["wow nice", "I knew you could put balls in holes", "ez"]
var INSULTS = ["good job idiot =]", "this wouldn't happen if you stopped playing GTA RP", "git gud loser"]

func get_random_insult():
	return INSULTS[randi() % INSULTS.size()]

func get_random_compliment():
	return COMPLIMENTS[randi() % COMPLIMENTS.size()]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_HoleFinishedPopup_about_to_show():
	print("here?")
	if Global.ballInHole:
		$Label.text = get_random_compliment()
	else:
		$Label.text = get_random_insult()

