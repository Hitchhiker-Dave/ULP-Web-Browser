extends Node2D

signal change_lock(lock_state)

onready var collision = $Area2D/CollisionShape2D
onready var collider = $Area2D
onready var audio = $Audio

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

func play_sound(sound):
	audio.stream = sound
	audio.pitch_scale = rand_range(0.95, 1.05)
	audio.play()

func update_lockstate():
	if isLocked:
			isLocked = false
			play_sound(unlock)
			
	elif isLocked == false:
		isLocked = true
		play_sound(lock)
		
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
	collision.shape.radius = radius
	#Should include a thing to disable collision circle for background elements
	if isButton != true:
		collider.visible = false
	
	update()

#Hover Effect
func _on_Area2D_mouse_entered():
	hovering = true
	update()

func _on_Area2D_mouse_exited():
	hovering = false
	update()

#Custom Mouse Input/Locking Mechanism
func _on_Area2D_input_event(_viewport, _event, _shape_idx): #should lookup what passed variables are for
	if Input.is_action_pressed("Click"): 
		update_lockstate()
		
	#(Hopefully allows for mobile browers to lock prompts)
	elif OS.has_feature("mobile") == true and self.InputEventScreenTouch.is_pressed() == true: 
		update_lockstate()
		
	update()
