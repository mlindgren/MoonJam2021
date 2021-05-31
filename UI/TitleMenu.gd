extends TextureRect

const FIRST_COURSE_PATH = "res://Courses/Hole1.tscn"

var selected_menu = 0
var preload_course : Resource

func _ready():
	preload_course = preload(FIRST_COURSE_PATH)

func _process(_delta):
	rect_scale =  get_viewport().size / rect_size

func _on_TextureButton_pressed():
	get_tree().change_scene(FIRST_COURSE_PATH)
