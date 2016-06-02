extends Node

export(NodePath) var questionTextPath
onready var questionText = get_node(questionTextPath)

export(NodePath) var buttonContainerPath
onready var buttonContainer = get_node(buttonContainerPath)

export(NodePath) var buttonReferencePath
onready var buttonReference = get_node(buttonReferencePath).duplicate()

signal optionClick(strid)
signal fadedIn()

var animating  = false
var text       = ""
var textLength = 0
var curChar    = 0
var choices    = []
var globDelta  = 0
var charTime   = 0.04

func _onOptionClick(strid):
	emit_signal("optionClick", strid)

func _makeButton(text):
	var btn = buttonReference.duplicate()
	btn.set_text(text)
	btn.connect("pressed", self, "_onOptionClick", [text])
	return btn

func _addOptions():
	for option in choices:
		var btn = _makeButton(text)
		buttonContainer.add_child(btn)

func _ready():
	buttonContainer.remove_child(get_node(buttonReferencePath))
	set_process(true)

func _process(delta):
	if animating:
		# Add delta
		globDelta += delta
		
		# New characters? Extract them
		var newChars = floor(globDelta / charTime)
		globDelta -= newChars * charTime
		
		curChar += newChars
		if curChar >= textLength:
			# End
			curChar = textLength
			animating = false
			emit_signal("fadedIn")
		
		# Extract substring with already faded in characters
		var txt = text.substr(0, curChar)

		# Trim bbcode
		var closed = txt.find_last("]")
		var opened = txt.find_last("[")
		if opened > closed:
			curChar = text.find("]", opened) + 1
			txt = text.substr(0, curChar)
		
		# Set as text
		questionText.set_bbcode(txt)
		
		# Still not at the end? Show next character
		if curChar < textLength:
			# Trim bbcode AGAIN (optimize in the future maybe?)
			txt = text.substr(0, curChar + 1)
			var closed = txt.find_last("]")
			var opened = txt.find_last("[")
			if opened > closed:
				curChar = text.find("]", opened) + 1
			
			# Use globDelta percent as shade of white for next character
			var nextCol = Color(1, 1, 1, globDelta / charTime)
			questionText.push_color(nextCol)
			questionText.add_text(text[curChar])
			questionText.pop()

func runScene():
	textLength = text.length()
	curChar    = 0
	globDelta  = 0
	animating  = true

func addOption(text):
	choices.append(text)

func setText(txt):
	text = txt

func clear():
	text = ""
	choices = []

	questionText.set_bbcode("")
	for child in buttonContainer.get_children():
		buttonContainer.remove_child(child)