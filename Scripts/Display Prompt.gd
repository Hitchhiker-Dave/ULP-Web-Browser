# Will display random text based off a table. Will limit this to NPC and Event Prompts, and make a 
# different node that handles siblings and Backstory using this object as a child

#Script will now only work when a parent to the object casts down a table for them to use

extends Node2D

export var repeatLines = 0

onready var Label = $Label

var prompt_modifier = [""] #Minor Issue where the parents won't override these variables until 
var prompt_noun = [""]		#the Reroll button is pressed


func newPrompt(var modifier, var noun):
	return ( str(modifier[randi() % modifier.size()]) + " " + str(noun[randi() % noun.size()]) )

func displayPrompt(var modifier, var noun):
	if repeatLines > 0:
		Label.text = "" #Needed to make sure the text field is cleared before a new prompt is generated
		for i in range(repeatLines):
			Label.text += newPrompt(modifier, noun) 
			if repeatLines > 1 and i < repeatLines - 1:
				Label.text += "\n"
		
	else:
		Label.text = "Reroll for New Prompt"

func _ready():
	displayPrompt(prompt_modifier, prompt_noun)

func _process(_delta):
	if Input.is_action_just_released("Reroll"):
		displayPrompt(prompt_modifier, prompt_noun)
