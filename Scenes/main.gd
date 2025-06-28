extends Control

@onready var grid_container: GridContainer = $VBoxContainer/GridContainer
@onready var question_label: RichTextLabel = $VBoxContainer/QuestionLabel
@onready var num_label: Label = $VBoxContainer/HBoxContainer/NumLabel
@onready var score_label: Label = $VBoxContainer/HBoxContainer/ScoreLabel
@onready var ending_screen: VBoxContainer = $EndingScreen
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var correct: AudioStreamPlayer = $Correct
@onready var wrong: AudioStreamPlayer = $Wrong
@onready var victory: AudioStreamPlayer = $Victory
@onready var defeat: AudioStreamPlayer = $Defeat

@onready var animation_player: AnimationPlayer = $AnimationRect/AnimationPlayer


@export var my_questions:QuestionList  = null
var current_question:int = 0

var score:float = 0

var animating:bool = false

func _ready():
	if my_questions != null:
		my_questions = Gloabl.current_list
	
	if my_questions != null:
		set_question()
		set_options()
		set_header()
		update_score()
		ending_screen.hide()
		v_box_container.show()
		
func set_ending():
	v_box_container.hide()
	ending_screen.show()
	ending_screen.update_label(score,check_pass())

func check_pass():
	var max:float = my_questions.questions.size()*10
	print(max," ",score/max)
	if score/max < 0.32:
		defeat.play()
		return false
	victory.play()
	return true
	
func set_header():
	num_label.text = "Question "+str(current_question+1) + "/" +str(my_questions.questions.size())
	
func set_options():
	var options = my_questions.questions[current_question].options
	for i in grid_container.get_child_count():
		grid_container.get_child(i).text = options[i]

func set_question():
	question_label.text = my_questions.questions[current_question].question

func option_clicked(option:int):
	if animating:
		return
	animating = true
	if option == my_questions.questions[current_question].answer:
		animation_player.play("Correct")
		correct.play()
		score += 10
	else:
		animation_player.play("Wrong")
		wrong.play()
		score -= 5

func move_to_next():
	current_question += 1
	if current_question >= my_questions.questions.size():
		current_question -= 1
		set_ending()
		return
	animating = false
	reset()

func update_score():
	score_label.text = "score = " +str(score)

func reset():
	set_header()
	set_question()
	set_options()
	update_score()


func _on_return_pressed() -> void:
	Gloabl.play()
	get_tree().change_scene_to_file("res://Scenes/main_screen.tscn")
