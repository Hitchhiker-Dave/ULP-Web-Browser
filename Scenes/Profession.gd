extends Node2D

onready var prompt = $Prompt
onready var sibling_count = $Sibling_Count

#technically not the proper logic for number siblings generated ?
func _ready():
	prompt.prompt_modifier = global.NPC_MODIFIER
	prompt.prompt_noun = global.NPC_NOUN
	prompt.repeatLines = 1

func _process(_delta):
	prompt.repeatLines = 1
