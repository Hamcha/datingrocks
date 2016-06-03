extends "res://Classes/Cutscene.gd"

func getName():
	return "Intro"

func getInitialScene():
	return "mesg1"

func mesg1():
	var text = "It's a brand new day{P:0.1}, and in front of you you see the [b]Geology school for stubborn minds \"[i]The Rock[/i]\"[/b].{P:1}\n"
	text += "Inside you will find all sorts of minerals waiting to be {P:0.5}\"thoroughly studied\"{P:0.3} and..{P:0.6} shall we say,{P:0.1} your rockmate?"
	.setText(text)
	.addOption("Awesome, I can't wait to get in!", "mesg2_good")
	.addOption("Wait, you want me to make out with some ROCKS?", "mesg2_bad")

func mesg2_good():
	.setText("Sadly there isn't much of the school left, a nuclear accident destroyed any living being, so all that's left are the rocks themselves.")
	.addOption("Oh.", "mesg3")

func mesg2_bad():
	var text = "Sorry, I forgot to mention that a nuclear bomb destroyed your entire species, so rocks are the only thing left now... "
	text += "It's still better than making out with dirt."
	.setText(text)
	.addOption("Oh.", "mesg3")

func mesg3():
	.setText("Since most of the game is missing, you can jump to parts that are in development but are somewhat present.")
	.addOption("Date a rock!", "jumpdate")