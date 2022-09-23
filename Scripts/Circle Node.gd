extends Node2D

signal change_lock(lock_state)

onready var collision = $Area2D/CollisionShape2D
onready var collider = $Area2D

onready var isLocked = false
onready var hovering = false

export var radius = 20
export var line_width = 5.0
export var isButton = true

var hoverSize = 1.5
var center = Vector2(0, 0)
var outerColor = Color(239,237,235)
const edges: int = 8192

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
		if isLocked:
			isLocked = false
		elif isLocked == false:
			isLocked = true
			
		emit_signal("change_lock", isLocked)
		
	update()
