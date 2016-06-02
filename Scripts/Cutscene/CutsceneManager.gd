extends Node

export(String) var cutsceneName
onready var cutscene = load("res://Cutscenes/" + cutsceneName + ".gd").new()

export(NodePath) var cutsceneUIPath
onready var cutsceneUI = get_node(cutsceneUIPath)

func _ready():
	cutscene.setUI(cutsceneUI)
	print("Loaded cutscene: " + cutscene.getName())
	cutscene.run()