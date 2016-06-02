var ui = null
var instance = null

func setUI(_ui):
	ui = _ui
	ui.connect("optionClick", self, "_dispatchCallback")

var callbacks = {}

func _runScene(scene):
	_clear()
	scene.call_func()
	ui.runScene()

func _dispatchCallback(strid):
	if callbacks.has(strid):
		_runScene(callbacks[strid])
	else:
		#TODO Better error handling?
		print("ERROR: Clicked button without callback set! (", strid, ")")

func _clear():
	callbacks = {}
	if ui != null:
		ui.clear()

func addOption(text, callback):
	callbacks[text] = funcref(self, callback)
	ui.addOption(text)

func setText(text):
	ui.setText(text)

func getName():
	return "<Unnamed cutscene>"

func getInitialScene():
	return "_empty"

func _empty():
	print("WARN: Running empty cutscene")
	setText("<NO CUTSCENE CONTENT>")

func run():
	var initial = funcref(self, getInitialScene())
	_runScene(initial)