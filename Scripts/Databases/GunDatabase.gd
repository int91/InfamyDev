extends Node

enum Firemodes {semi, auto, burst, shotgun}
enum Types {primary, secondary, all}

var GunData = {
	"1":{
		"name":"CAR-15",
		"damage":30,
		"ammo":30,
		"maxAmmo":30,
		"reserveAmmo":240,
		"minRecoilDisplacement":0.1,
		"maxRecoilDisplacement":0.25,
		"firerate":0.1,
		"barrelOffset":Vector2(30, 0),
		"firemode":Firemodes.auto,
		"type":Types.primary,
		"reloadTime":1,
		"reloadSpeed":1,
		"sightAttachment":null,
		"magAttachment":null,
		"barrelAttachment":null,
		"stockAttachment":null,
		"underbarrelAttachment":null,
		"ammotypeAttachment":null,
		"attachmentsChecked":false,
		"unlockLevel":0,
		"salePrice":6000,
		"sprite":"res://icon.png",
		"scaleX":0,
		"scaleY":0
	},
	"2":{
		"name":"RE-45",
		"damage":39,
		"ammo":15,
		"maxAmmo":15,
		"reserveAmmo":120,
		"minRecoilDisplacement":0.15,
		"maxRecoilDisplacement":0.45,
		"firerate":0.05,
		"barrelOffset":Vector2(30, 0),
		"firemode":Firemodes.auto,
		"type":Types.primary,
		"reloadTime":1,
		"reloadSpeed":1,
		"sightAttachment":"red_dot_1",
		"magAttachment":"extended_pistol_0",
		"barrelAttachment":null,
		"stockAttachment":null,
		"underbarrelAttachment":null,
		"ammotypeAttachment":"hp_ap_combo_0",
		"attachmentsChecked":false,
		"unlockLevel":0,
		"salePrice":12000,
		"sprite":"res://icon.png",
		"scaleX":0,
		"scaleY":0
	},
	#This is the gun for when a gun that's being searched can't be found or doesn't exist.
	"0":{
		"name":"ERROR: NO GUN FOUND",
		"damage":0,
		"ammo":0,
		"maxAmmo":0,
		"reserveAmmo":120,
		"minRecoilDisplacement":0.1,
		"maxRecoilDisplacement":0.25,
		"firerate":0.1,
		"barrelOffset":Vector2(7, 7),
		"firemode":Firemodes.auto,
		"type":Types.all,
		"reloadTime":1,
		"reloadSpeed":1,
		"sightAttachment":null,
		"magAttachment":null,
		"barrelAttachment":null,
		"stockAttachment":null,
		"underbarrelAttachment":null,
		"ammotypeAttachment":null,
		"attachmentsChecked":false,
		"unlockLevel":0,
		"salePrice":0,
		"sprite":"res://icon.png",
		"scaleX":0,
		"scaleY":0
	}
}

#Checks to see if the id a gun exists and then when it exists it returns the gun data
func _getgun(ID):
	if ID in GunData:
		return GunData[ID]
	else:
		return GunData["0"]
	pass
