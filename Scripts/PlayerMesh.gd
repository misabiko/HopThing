extends MeshInstance

onready var player = $".."
var aimed_scale = 1

func _process(delta):
	#print(player.linear_velocity.length())
	scale.y = 1 + clamp(player.linear_velocity.length(), 0, 50) / 100
	rotation_degrees.z = rad2deg(atan2(player.linear_velocity.y, player.linear_velocity.x)) - 90
