extends Node2D

onready var prompt = $Prompt

func generate_events():
	prompt.repeatLines = (randi() % 3  + 1)

func _ready():
	prompt.prompt_modifier = global.EVENT_MODIFIER
	prompt.prompt_noun = global.EVENT_NOUN
	generate_events()

func _process(_delta):
	if Input.is_action_just_released("Reroll"):
		generate_events()
