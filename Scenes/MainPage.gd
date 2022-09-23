extends Node2D

onready var audio = $Audio

#Audio Paths
const die1 = preload("res://Sounds/dice1.wav")
const die2 = preload("res://Sounds/dice2.wav")
const die3 = preload("res://Sounds/dice3.wav")
const die4 = preload("res://Sounds/dice4.wav")
const die5 = preload("res://Sounds/dice5.wav")

var diceSounds = [die1, die2, die3, die4, die5]

func _on_Reroll_Button_pressed():
	#Simulate R/Space Being Pressed
	Input.action_press("Reroll")
	Input.action_release("Reroll") #needed since the prompt only generates when the key is released

func _ready():
	randomize()

func _process(_delta):
	if Input.is_action_just_released("Reroll"):
		audio.stream = diceSounds[randi() % diceSounds.size()]
		audio.pitch_scale = rand_range(0.90, 1.10)
		audio.play()
