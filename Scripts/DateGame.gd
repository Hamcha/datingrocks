extends Node

var Date = preload("res://Classes/Date.gd")

export(NodePath) var dateUIPath
onready var dateUI = get_node(dateUIPath)

func _ready():
	if !dateUI.is_ready:
		yield(dateUI, "ready")