extends Node

signal projects_ready(projects)

func _ready():
	call_deferred("_emit_projects_ready")

# Temp. signal for test purpose
func _emit_projects_ready():
	var project = {
		"name": "OuroDev QA",
		"webpage": "https://qa.ourodev.com"
	}
	var projects = [project]
	emit_signal("projects_ready", projects)

# Experimental stuff -----------------------------

#func load_save() -> Dictionary:
#	var f := File.new()
#	f.open("user://config.json", File.READ)
#	var result := JSON.parse(f.get_as_text())
#	f.close()
#
#	if result.error:
#		printerr("Failed to parse save file: ", f.error_string)
#	return result.result as Dictionary
#
#func save(data: Dictionary):
#	var f := File.new()
#	f.open("user://config.json", File.WRITE)
#	prints("Saving to", f.get_path_absolute())
#	f.store_string(JSON.print(data))
#	f.close()
#
#func _on_Button_pressed():
#	save({
#		"remote": {
#			"manifests": ["https://qa.ourodev.com/patch/manifest.xml"]
#		},
#		"local": {
#			"root": "D:/Games/Ourodev"
#		}
#	})
