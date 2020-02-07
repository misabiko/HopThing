extends Spatial

onready var player = $".."/Player
export(float) var gap = 7
export(float) var noise = 1

func _ready():
	for p in get_children():
		p.get_node("VisibilityNotifier").connect("screen_exited", self, "_on_Platform_screen_exited")

func _on_Platform_screen_exited():
	var moved_platform = get_children().front()
	moved_platform.translation.x = rand_range(-11, 11)
	moved_platform.translation.y = get_children().back().translation.y + gap + rand_range(-noise, noise)
	
	call_deferred("move_child", moved_platform, get_child_count() - 1)

func _process(delta):
	pass
