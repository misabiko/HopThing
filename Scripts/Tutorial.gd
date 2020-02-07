extends Label

onready var bottom_wall = $".."
onready var cam = $"../.."/Camera
var offset : Vector2

func _ready():
	var pos = bottom_wall.translation
	var screenPos = cam.unproject_position(pos)
	offset = rect_position - screenPos

func _process(delta):
	var pos = bottom_wall.translation
	var screenPos = cam.unproject_position(pos)
	rect_position = screenPos + offset
