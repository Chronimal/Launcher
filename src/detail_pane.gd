extends Panel

func _add_project_settings():
	var packed = ResourceLoader.load("res://src/project_settings.tscn")
	var project_settings = get_node("Details/Settings/ProjectSettings")
	project_settings.add_child(packed.instance())

func _on_PatchNodesButton_focus_entered():
	$SettingsButton.set_pressed(false)

func _on_SettingsButton_focus_entered():
	$PatchNodesButton.set_pressed(false)

func _on_PatchNodesButton_pressed():
	$Details.set_current_tab(0)

func _on_SettingsButton_pressed():
	$Details.set_current_tab(1)

func _on_PatchNodes_meta_clicked(meta):
	if typeof(meta) == TYPE_STRING:
		#warning-ignore:return_value_discarded
		OS.shell_open(meta)

func _on_AddProjectButton_pressed():
	_add_project_settings()
