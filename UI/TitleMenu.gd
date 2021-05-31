extends TextureRect

var selected_menu = 0

func _process(_delta):
	rect_scale =  get_viewport().size / rect_size

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Courses/Hole1.tscn")
