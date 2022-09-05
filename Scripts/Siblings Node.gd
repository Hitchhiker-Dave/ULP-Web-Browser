extends Node2D

onready var prompt = $Prompt
onready var sibling_count = $Sibling_Count
var number

func sibling_roll():
	var check = (randi() % 3 + 1)
	match check:
		1: 
			number = 0
		2:
			number = 1
		3:
			number = (randi() % 3 + 1) 
	return number

func generate_siblings():
	number = sibling_roll()
	sibling_count.text = str(number)
	prompt.repeatLines = number

#technically not the proper logic for number siblings generated; need to make a function for the roll
func _ready():
	prompt.prompt_modifier = global.NPC_MODIFIER 
	prompt.prompt_noun = global.NPC_NOUN 
	generate_siblings()

func _process(_delta):
	if Input.is_action_just_released("Reroll"):
		generate_siblings()
