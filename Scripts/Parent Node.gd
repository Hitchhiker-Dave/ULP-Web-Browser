extends Node2D

onready var prompt = $Prompt
onready var sibling_count = $Sibling_Count
var number

func generate_parents():
	prompt.repeatLines = (randi() % 2 + 1)

#technically not the proper logic for number siblings generated ?
func _ready():
	prompt.prompt_modifier = global.NPC_MODIFIER
	prompt.prompt_noun = global.NPC_NOUN
	generate_parents()

func _process(_delta):
	if Input.is_action_just_released("Reroll"):
		generate_parents()
