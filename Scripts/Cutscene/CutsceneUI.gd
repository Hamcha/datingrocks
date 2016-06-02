extends Node

export(NodePath) var questionTextPath
onready var questionText = get_node(questionTextPath)

export(NodePath) var buttonContainerPath
onready var buttonContainer = get_node(buttonContainerPath)

export(NodePath) var buttonReferencePath
onready var buttonReference = get_node(buttonReferencePath).duplicate()

var is_ready = false
signal ready()

signal optionClick(strid)

func _onOptionClick(strid):
	emit_signal("optionClick", strid)

func _makeButton(text):
	var btn = buttonReference.duplicate()
	btn.set_text(text)
	btn.connect("pressed", self, "_onOptionClick", [text])
	return btn

func resetOptions():
	for child in buttonContainer.get_children():
		buttonContainer.remove_child(child)

func addOption(text):
	var btn = _makeButton(text)
	buttonContainer.add_child(btn)

func setText(text):
	#TODO Add animation
	questionText.set_bbcode(text)

func _ready():
	buttonContainer.remove_child(get_node(buttonReferencePath))
	emit_signal("ready")
	is_ready = true