extends Node

export(NodePath) var questionTextPath
onready var questionText = get_node(questionTextPath)

export(NodePath) var buttonContainerPath
onready var buttonContainer = get_node(buttonContainerPath)

var is_ready = false
signal ready()

signal optionClick(strid)

func _onOptionClick(strid):
	emit_signal("optionClick", strid)

func _makeButton(strid, text):
	var btn = Button.new()
	btn.set_text(text)
	btn.set_v_size_flags(btn.SIZE_EXPAND_FILL)
	btn.connect("pressed", self, "_onOptionClick", [strid])
	return btn

func resetOptions():
	for child in buttonContainer.get_children():
		buttonContainer.remove_child(child)

func addOption(strid, text):
	var btn = _makeButton(strid, text)
	buttonContainer.add_child(btn)

func setText(text):
	#TODO: Add animation
	questionText.set_bbcode(text)

func _ready():
	emit_signal("ready")
	is_ready = true