extends Node2D

signal change_lock(lock_state)

onready var collision = $Area2D/CollisionShape2D
onready var collider = $Area2D
onready var audio = $Audio

onready var isMobileEnvironment = false
onready var isLocked = false
onready var hovering = false

export var radius = 20
export var line_width = 5.0
export var isButton = true

var hoverSize = 1.5
var center = Vector2(0, 0)
var outerColor = Color(239,237,235)
const edges: int = 8192

#audio
const unlock = preload("res://Sounds/unlockprompt.wav")
const lock = preload("res://Sounds/lockprompt.wav")

func play_sound(sound, pitchMin, pitchMax):
	audio.stream = sound
	audio.pitch_scale = rand_range(pitchMin, pitchMax)
	audio.play()

func update_lockstate():
	if isLocked:
		isLocked = false
		play_sound(unlock, 1.00, 1.05)
			
	elif isLocked == false:
		isLocked = true
		play_sound(lock, 0.95, 1.00)
	
	emit_signal("change_lock", isLocked)
	
func _draw():
	if isLocked:
		if hovering:
			draw_circle(center, radius * hoverSize, outerColor)
		else:
			draw_circle(center, radius, outerColor)	
	else:
		if hovering:
			draw_arc(center, radius * hoverSize, 0, 360, edges, outerColor, line_width , true)
		else:
			draw_arc(center, radius, 0, 360, edges, outerColor, line_width , true)
	
func _ready():
	#check if on mobile platform or debuging mobile input
	if OS.has_touchscreen_ui_hint() == true or global.mouseDebug == true:
		isMobileEnvironment = true
		collision.shape.radius = radius * ( hoverSize + 1)
		hovering = true
		
	else:
		collision.shape.radius = radius
	
	#Disable Collision for certain instances
	if isButton != true:
		collider.visible = false
		hovering = false
	
	update()

#Hover Effect
func _on_Area2D_mouse_entered():
	hovering = true
	
	#Checks if in mobile environment to so that mobile can lock prompts accurately
	#Currently has issue where it can't immediately toggle and untoggle; Circle Node may need complete rework
	#Maybe convert to a control node instead if people complain enough
	if isMobileEnvironment == true:
		update_lockstate()
		
	
	update()

func _on_Area2D_mouse_exited():
	if isMobileEnvironment != true:
		hovering = false
		
	
	update()
		
#Custom Mouse Input Locking Mechanism
#Should Disable and Renable mouse when testing touch inputs on screen: https://www.reddit.com/r/godot/comments/cyt8g1/how_do_i_disable_mouse_from_my_game/
func _on_Area2D_input_event(_viewport, _event, _shape_idx): #should lookup what passed variables are for
	if isMobileEnvironment != true and Input.is_action_pressed("Click"): 
		update_lockstate()
		
	update()
