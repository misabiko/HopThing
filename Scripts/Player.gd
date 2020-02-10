extends RigidBody

const DEFAULT_CHARGE = 0
var aiming = false
var charging = false
export(float) var CHARGE_SPEED = 3.0
export(float) var angleVel = 3

onready var charge_bar = $ChargeBar
onready var player_mesh = $PlayerMesh
#var can_jump = true

onready var score_text = $".."/Score
onready var highscore_text = $".."/HighScore
var score = 0
var score_file = "user://highscore.save"
var highscore = 0

onready var platform_manager = $".."/PlatformManager
onready var bottom_wall = $".."/Walls/BottomWall

export(float, EASE) var charge_easing = 0.5

var can_play = true

func _ready():
	charge_bar.value = DEFAULT_CHARGE
	load_score()

func load_score():
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		var content = f.get_as_text()
		highscore = int(content)
		f.close()

func save_score():
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(str(highscore))
	f.close()

func _process(delta):
	if aiming:
		charge_bar.rect_rotation += angleVel
		if charge_bar.rect_rotation > 360 or charge_bar.rect_rotation < 180:
			charge_bar.rect_rotation = clamp(charge_bar.rect_rotation, 180, 360)
			flipAngleVel()
			
	set_score()
	charge_bar.value = max(0, charge_bar.value + 8 * CHARGE_SPEED * delta * (1 if charging else -1))

func jump():
	var direction = Vector3.RIGHT.rotated(Vector3.FORWARD, deg2rad(charge_bar.rect_rotation - 360))
	apply_impulse(Vector3.ZERO, max(0, charge_bar.value) * direction)
	charge_bar.value = 0
	charge_bar.min_value = 0
	flipAngleVel()

func _input(event):
	if can_play and event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				aiming = event.is_pressed()
				if !event.is_pressed():
					jump()
				else:
					charge_bar.min_value = -5
			BUTTON_RIGHT:
				charging = event.is_pressed()
	elif can_play and event is InputEventScreenTouch:
		match event.index:
			0:
				aiming = event.is_pressed()
				if !event.is_pressed():
					jump()
			1:
				charging = event.is_pressed()
	#elif event is InputEventMouseMotion:
	#	charge_bar.value = charge_bar.max_value * ease(1 - event.position.y / get_viewport().size.y, charge_easing)

func flipAngleVel():
	angleVel = -angleVel

func set_score():
	var new_score = max(0, round(translation.y - 4))
	score = new_score if new_score > score else score
	if score > highscore:
		highscore = score
		save_score()
	
	score_text.text = "Score: " + String(score)
	highscore_text.text = "HighScore: " + String(highscore)

func death():
	charging = false
	aiming = false
	can_play = false
	charge_bar.value = 0
	$".."/GameOver.game_over()


func _on_VisibilityNotifier_screen_exited():
	death()
