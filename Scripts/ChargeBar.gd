extends TextureProgress

onready var cam = $"../.."/Walls/Camera
onready var player = $".."
var offset = Vector2(50, -12)

func _ready():
	rect_rotation = 270

func _process(delta):
	var pos = player.translation
	var screenPos = cam.unproject_position(pos)
	rect_position = screenPos + offset
