extends StaticBody2D

var hovered = false
var price = 980
var guns = []

func _ready():
	for i in range(GunDatabase.GunData.size()):
		if (GunDatabase.GunData[str(i)].name != "ERROR: NO GUN FOUND"):
			guns.append(GunDatabase.GunData[str(i)])
		pass
	print(str(guns))
	pass

func interact():
	pass

func _on_Area2D_mouse_entered():
	if (PlayerData.canInteract):
		hovered = true
		PlayerData.objectToInteract = self
	pass


func _on_Area2D_mouse_exited():
	hovered = false
	if (PlayerData.objectToInteract != null):
		PlayerData.objectToInteract = null
	pass
