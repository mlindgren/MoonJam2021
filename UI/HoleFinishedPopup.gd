extends PopupDialog

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
	"If your fake wife could see this she'd be crying",
	"No wonder you never finished Vypur's game",
	"Bronze league skills",
	"Go back to Overwatch",
	"Don't quit your day job... oh, wait"
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
