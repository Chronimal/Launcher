extends TextureRect

var _drag_state = 0
var _drag_offset = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().set_transparent_background(true)
	#warning-ignore:return_value_discarded
	Global.connect("projects_ready", self, "_on_projects_ready")

func _on_Launcher_gui_input(event):
	if event.is_class("InputEventMouse"):
		if _drag_state == 0 and event.is_class("InputEventMouseButton") and event.button_index == BUTTON_LEFT and event.pressed:
			_drag_state = 1
			_drag_offset = OS.window_position - (event.global_position + OS.window_position)
		if _drag_state == 1 and event.is_class("InputEventMouseMotion"):
			_drag_state = 2
		if _drag_state == 2 and event.get_button_mask() != BUTTON_LEFT:
			_drag_state = 0

func _process(_delta):
	if _drag_state == 2:
		OS.window_position = (get_viewport().get_mouse_position() + OS.window_position) + _drag_offset

# Signal handling
func _on_CloseButton_pressed():
	get_tree().quit()

func _on_MinimizeButton_pressed():
	if not OS.is_window_minimized():
		OS.set_window_minimized(true)

func _on_AudioOnButton_pressed():
	_play_music(false)

func _on_AudioOffButton_pressed():
	_play_music(true)

func _on_projects_ready(_projects):
	_add_scene("res://src/project_pane.tscn")
	_add_scene("res://src/detail_pane.tscn")
	_add_scene("res://src/install_pane.tscn")
	_play_music(true)

func _add_scene(path):
	var packed = ResourceLoader.load(path)
	var instanced = packed.instance()
	get_tree().get_root().add_child(instanced)

func _play_music(play : bool):
	$AudioPlayer.playing = play
	$AudioOnButton.disabled = !play
	$AudioOnButton.visible = play
	$AudioOffButton.disabled = play
	$AudioOffButton.visible = !play
