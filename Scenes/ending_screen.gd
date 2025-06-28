extends VBoxContainer

@onready var score_label: Label = $ScoreLabel

func update_label(score:int,passing:bool = false):
	score_label.text = "your final score is " + str(score) + "\n" + "you "
	score_label.text += "passed" if passing else "failed"
