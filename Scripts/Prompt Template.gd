extends Node2D

enum PromptType {
	none, 
	event,
	parents,
	history,
	sibling,
	profession,
}

export var type = PromptType
export var version = 0 #It's the same as PromptType but godot doesn't like custom types being exported

onready var prompt = $Prompt
onready var label = $Header/Label
onready var line = $Header/HeaderLine

onready var lockPrompt = false

#Functions for different Prompt Types
func generate_prompt(max_number):
	return (randi() % max_number  + 1)

func npc_setup():
	prompt.prompt_noun = global.NPC_NOUN
	prompt.prompt_modifier = global.NPC_MODIFIER

func event_setup():
	prompt.prompt_noun = global.EVENT_NOUN
	prompt.prompt_modifier = global.EVENT_MODIFIER

func sibling_roll():
	var check = (randi() % 3 + 1)
	match check:
		1: 
			return 0
		2:
			return 1
		3:
			return (randi() % 3 + 1)

#Main
#Basically I'm using the PromptType enum + match/switch to filter which tables and methods to use 
func _ready():
	match version:
		1: #Important Event Prompts
			label.text = "Important Event(s)"
			label.get_canvas_transform()
			event_setup()
			prompt.repeatLines = generate_prompt(3)
			
		2: #Parents Prompt
			label.text = "Parent(s)"
			npc_setup()
			prompt.repeatLines = generate_prompt(2)
			
		3: #Personal History Prompt
			label.text = "Personal History"
			event_setup()
			prompt.repeatLines = generate_prompt(3)
			
		4: #Siblings
			var number = sibling_roll()
			label.text = ( "Siblings: " + str(number) )
			npc_setup()
			prompt.repeatLines = number
			
		5: #Profession
			label.text = "(Optional) Profession"
			npc_setup()
			prompt.repeatLines = 1
			
		_: #Default/Error
			label.text = "Error"
	
	line.rect_size.x = label.get_total_character_count() * 22 #Scales line to length of header text

#Needed so that it generates a different amount of prompts each time
func _process(_delta):
	if lockPrompt != true and Input.is_action_just_released("Reroll"):
		match version:
			1: #Important Events
				prompt.repeatLines = generate_prompt(3)
				
			2: #Parents
				prompt.repeatLines = generate_prompt(2)
				
			3: #Personal History
				prompt.repeatLines = generate_prompt(3)
				
			4: #Siblings
				var number = sibling_roll()
				label.text = ( "Siblings: " + str(number) )
				prompt.repeatLines = number
				
			5: #Profession
				label.text = "(Optional) Profession"
				npc_setup()
				prompt.repeatLines = 1
			
			_: #Default/Error
				prompt.repeatLines = 1

func _on_Circle_Node_change_lock(lock_state):
	lockPrompt = lock_state
	prompt.isLocked = lock_state
