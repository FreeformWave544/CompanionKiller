extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	$Label6.text = "YOUR SINS DO NOT JUST VANISH WITH THE CLICK OF A BUTTON"
	$Container/Label.text = ""
	$Container/Label2.text = "Gerald? Remember him? OF COURSE YOU DON'T! You kill him before you got to know him.\nAnd Almond? No! You just chucked that raisin at them and they poofed. You treated them like a worthless doll, when we know dolls are very valueable!\nAll these faces... all these families. All they WANTED was you!\nDid they get it? OF COURSE NOT!\nBut that cat.\nOf COURSE they live.\nOf course you let them see their family again.\nWhy?\nWhy?\nWHY DID YOU LET THAT CAT LIVE BUT NOT THE OTHERS?!?!"
	$Container/Label3.text = ""
	$Container/Label4.text = ""
	$Container/Label5.text = ""
