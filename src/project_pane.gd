extends Panel

func _ready():
	$Project.add_item("Ourodev")
	$Links.add_child(_create_link_button("Welcome Hub"))
	$Links.add_child(_create_link_button("Official Site"))
	$Links.add_child(_create_link_button("FAQ"))

func _create_link_button(text):
	var link = LinkButton.new()
	link.underline = LinkButton.UNDERLINE_MODE_NEVER
	link.text = text
	return link

