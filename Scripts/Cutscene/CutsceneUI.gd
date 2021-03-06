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
var pausing    = false
var remPause   = 0
var text       = ""
var textLength = 0
var curChar    = 0
var choices    = []
var globDelta  = 0
var charTime   = 0.04
var lastCmd    = 0

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

func _runCommand(cmd):
	var parts = cmd.split(":")
	if parts[0] == "P":
		pausing = true
		remPause = float(parts[1])

func _ready():
	buttonContainer.remove_child(get_node(buttonReferencePath))
	set_process(true)

func _process(delta):
	if pausing:
		remPause -= delta
		if remPause <= 0:
			pausing = false
		return
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
		
		# Parse command, if encountered
		var closed = txt.find_last("}")
		var opened = txt.find_last("{")
		# Trim it
		if opened > closed:
			curChar = text.find("}", opened) + 1
		# Find and execute
		if opened > lastCmd:
			var cmd = text.substr(opened + 1, curChar - opened - 2)
			_runCommand(cmd)
			lastCmd = opened
		
		# Trim commands
		while true:
			opened = txt.find("{")
			if opened < 0:
				break
			closed = txt.find("}")
			if closed < 0:
				break
			txt = txt.left(opened) + txt.right(closed + 1)

		# Trim bbcode
		closed = txt.find_last("]")
		opened = txt.find_last("[")
		if opened > closed:
			curChar = text.find("]", opened) + 1
			txt = text.substr(0, curChar)
		
		# Set as text
		questionText.set_bbcode(txt)
		
		# Still not at the end? Show next character
		if !pausing && curChar < textLength:
			# Trim bbcode AGAIN (optimize in the future maybe?)
			txt = text.substr(0, curChar + 1)
			closed = txt.find_last("]")
			opened = txt.find_last("[")
			if opened > closed:
				curChar = text.find("]", opened) + 1
			# Trim commands AGAIN (like above)
			closed = txt.find_last("}")
			opened = txt.find_last("{")
			if opened > closed:
				curChar = text.find("}", opened) + 1
			
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
	pausing    = false
	remPause   = 0

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