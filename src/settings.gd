extends ScrollContainer

export var scrollbar_margin = 16

func _ready():
	var scroll_bar = get_v_scrollbar()
	scroll_bar.connect("visibility_changed", self, "_on_VScrollBar_visibility_changed")

func _on_VScrollBar_visibility_changed():
	var x = get_parent_control().rect_size.x
	var scroll_bar = get_v_scrollbar()
	var child = get_child(0)
	if scroll_bar.visible:
		child.rect_min_size.x = x - scroll_bar.rect_size.x - scrollbar_margin
	else:
		child.rect_min_size.x = x

func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
