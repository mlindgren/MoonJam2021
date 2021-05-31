extends TextureRect

const FIRST_COURSE_PATH = "res://Courses/Hole1.tscn"

var selected_menu = 0
var preload_course : Resource

onready var title = $Title

var time = 0

func _ready():
	preload_course = preload(FIRST_COURSE_PATH)

func _process(delta):
	rect_scale =  get_viewport().size / rect_size
	
	time += delta
	var scale_multiplier = 1.0 + sin(time) * 0.2
	title.rect_scale = Vector2(1, 1) * scale_multiplier

func _on_GodGamerModeButton_pressed():
	Global.game_mode = Global.GAME_MODE.GOD_GAMER
	get_tree().change_scene(FIRST_COURSE_PATH)

func _on_HardstuckPlatButton_pressed():
	Global.game_mode = Global.GAME_MODE.HARDSTUCK_PLAT
	get_tree().change_scene(FIRST_COURSE_PATH)
