extends Camera

onready var player = $"../.."/Player

func _process(_delta):
	transform.origin.y = max(transform.origin.y, player.transform.origin.y)
