extends "res://Classes/Cutscene.gd"

func getName():
	return "Intro"

func run():
	.setText("It's a brand new day, and in front of you you see the [b]Geology school for stubborn minds \"[i]The Rock[/i]\"[/b]")
	.addOption("Ciao", "mesg2")
	.addOption("no", "mesg3")

func mesg2():
	.setText("Ciao a te")

func mesg3():
	.setText("wow rude")