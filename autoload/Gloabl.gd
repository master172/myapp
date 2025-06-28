extends Node

var current_list:QuestionList = null
@onready var select: AudioStreamPlayer = $Select

func play():
	select.play()
