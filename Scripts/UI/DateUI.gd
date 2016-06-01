extends Node

export(NodePath) var questionTextPath
onready var questionText = get_node(questionTextPath)

export(NodePath) var buttonContainerPath
onready var buttonContainer = get_node(buttonContainerPath)

func onOptionClick(strid):
	print("Clicked \"", strid, "\"")

func makeButton(strid, text):
	var btn = Button.new()
	btn.set_text(text)
	btn.set_v_size_flags(btn.SIZE_EXPAND_FILL)
	btn.connect("pressed", self, "onOptionClick", [strid])
	return btn

func resetOptions():
	for child in buttonContainer.get_children():
		buttonContainer.remove_child(child)

func addOption(strid, text):
	var btn = makeButton(strid, text)
	buttonContainer.add_child(btn)

func setText(text):
	#TODO: Add animation
	questionText.set_bbcode(text)

func _ready():
	setText("usciamo a cena? porto mia sorella")
	addOption("lol", "lol haha")
	addOption("no", "no.")
	addOption("evil", "solo se mi bombo ANCHE tua sorella")