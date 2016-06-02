var ui = null
var instance = null

func setUI(_ui):
	ui = _ui
	ui.connect("optionClick", self, "dispatchCallback")

var callbacks = {}

func dispatchCallback(strid):
	if (callbacks.has(strid)):
		var cback = callbacks[strid]
		clear()
		cback.call_func()
	else:
		#TODO Better error handling?
		print("ERROR: Clicked button without callback set! (", strid, ")")

func addOption(text, callback):
	callbacks[text] = funcref(self, callback)
	ui.addOption(text)

func setText(text):
	ui.setText(text)

func clear():
	callbacks = {}
	if ui != null:
		ui.resetOptions()

func getName():
	return "<Unnamed cutscene>"

func run():
	print("WARN: Running empty cutscene")
	setText("<Empty cutscene>")