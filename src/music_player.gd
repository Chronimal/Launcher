extends AudioStreamPlayer

class_name MusicPlayer

enum Operation {
	NONE,
	FADE_IN,
	FADE_OUT
}

onready var _fader = get_node("Fader")
var _current_op = Operation.NONE
var _shuffled_streams = []

export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE
export (Array, AudioStream) var streams = []

func _ready():
	randomize()

func shuffle(play : bool):
	if streams.size() > 0:
		if play:
			_fade_in()
		else:
			_fade_out()

func _play_next():
	if _shuffled_streams.size() == 0:
		_shuffled_streams = streams.duplicate()
		_shuffled_streams.shuffle()
	if playing:
		stop()
	stream = _shuffled_streams.pop_back()
	stream.loop = false
	play()

func _fade_in():
	_fader.interpolate_property(self, "volume_db", -80, 0, transition_duration, transition_type, Tween.EASE_IN, 0)
	_current_op = Operation.FADE_IN
	_fader.start()

func _fade_out():
	_fader.interpolate_property(self, "volume_db", volume_db, -80, transition_duration, transition_type, Tween.EASE_OUT, 0)
	_current_op = Operation.FADE_OUT
	_fader.start()

func _on_Fader_tween_started(_object, _key):
	if _current_op == Operation.FADE_IN:
		_play_next()

func _on_Fader_tween_completed(_object, _key):
	if _current_op == Operation.FADE_OUT:
		stop()
	_current_op = Operation.NONE

func _on_MusicPlayer_finished():
	_play_next()
