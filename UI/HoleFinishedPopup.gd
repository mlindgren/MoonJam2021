extends PopupDialog

const COMPLIMENTS = [
	"wow nice",
	"I knew you could put balls in holes",
	"ez"
]

const INSULTS = [
	"good job idiot =]",
	"Somebody's been spending too much time playing GTA RP",
	"git gud loser",
	"You golf worse than you drive",
	"I thought you were a God Gamer",
	"old shit fat bald",
	"you suck lole"
]

func get_random_insult():
	return INSULTS[randi() % INSULTS.size()]

func get_random_compliment():
	return COMPLIMENTS[randi() % COMPLIMENTS.size()]
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _on_HoleFinishedPopup_about_to_show():
	if Global.ballInHole:
		$Label.text = get_random_compliment()
	else:
		$Label.text = get_random_insult()
