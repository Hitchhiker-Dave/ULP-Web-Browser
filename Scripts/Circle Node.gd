extends Node2D

export var radius = 20
export var line_width = 10.0


var center = Vector2(0, 0)
var color = Color(255,255,255)

func _ready():
	
	_draw()


func _draw():
	#Hollow Circle
	draw_arc(center, radius, 0, 360, 7777, color, line_width , true)
