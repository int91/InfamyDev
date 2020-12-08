extends Node

var sightAttachments = {
	"red_dot_1":{
			"name":"Red-Dot 1",
			"minRecoilChange": -0.05,
			"maxRecoilChange": -0.1,
			"sprite":"",
			"guns":["RE-45", "CAR-15"]
		},
	"red_dot_2":{
			"name":"Red-Dot 2",
			"minRecoilChange": -0.1,
			"maxRecoilChange": -0.15,
			"sprite":"",
			"guns":["RE-45"]
		}
}

var magAttachments = {
	"extended_pistol_0":{
		"name":"Pistol Drummag",
		"maxAmmoChange": 25,
		"maxRecoilChange": 0.1,
		"sprite":"",
		"guns":["RE-45"]
	}
}

var barrelAttachments = {
	
}

var stockAttachments = {
	
}

var underbarrelAttachments = {
	
}

var ammotypeAttachments = {
	"hp_ap_combo_0":
		{
			"name":"Hollow Armor Pierce",
			"damageChange":10,
			"sprite":"",
			"guns":["RE-45"]
		}
}

func _getAttachment(AttachmentID):
	if AttachmentID in sightAttachments:
		return sightAttachments[AttachmentID]
	elif AttachmentID in magAttachments:
		return magAttachments[AttachmentID]
	elif AttachmentID in barrelAttachments:
		return barrelAttachments[AttachmentID]
	elif AttachmentID in stockAttachments:
		return stockAttachments[AttachmentID]
	elif AttachmentID in underbarrelAttachments:
		return underbarrelAttachments[AttachmentID]
	elif AttachmentID in ammotypeAttachments:
		return ammotypeAttachments[AttachmentID]
	else:
		return print("Attachment not found [" + AttachmentID + "]")
	pass
