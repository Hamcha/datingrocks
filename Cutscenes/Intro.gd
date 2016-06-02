extends "res://Classes/Cutscene.gd"

func getName():
	return "Intro"

func run():
	.setText("lol")
	.addOption("Ciao", "mesg2")
	.addOption("no", "mesg3")

func mesg2():
	.setText("Ciao a te")

func mesg3():
	.setText("wow rude")