//Configuration for Airdrop Assistance
//Author: Apoc

APOC_AA_coolDownTime = 60; //Expressed in sec

APOC_AA_VehOptions =
[ // ["Menu Text",		ItemClassname,				Price,	"Drop Type"]
["Quadbike (Civilian)", "C_Quadbike_01_F", 			1000, 	"vehicle"],
["Offroad HMG", 		"B_G_Offroad_01_armed_F",	4500, 	"vehicle"],
["Hunter HMG", 			"B_MRAP_01_hmg_F", 			50000, 	"vehicle"],
["MH-9 Hummingbird", 	"B_Heli_Light_01_F", 		50000, 	"vehicle"],
["IFV-6a Cheetah AA", 	"B_APC_Tracked_01_AA_F", 	150000, "vehicle"],
["T-100 Varsuk", 		"O_MBT_02_cannon_F", 		175000, "vehicle"]
];

APOC_AA_SupOptions =
[// ["stringItemName", 	"Crate Type for fn_refillBox 	,Price," drop type"]
["Launchers", 			"airdrop_Launchers", 			60000, "supply"],
["Assault Rifle", 		"mission_USSpecial", 			35000, "supply"],
["Sniper Rifles", 		"airdrop_Snipers", 				50000, "supply"],
["DLC Rifles", 			"airdrop_DLC_Rifles", 			45000, "supply"],
["DLC LMGs", 			"airdrop_DLC_LMGs", 			45000, "supply"],

//"Menu Text",			"Crate Type", 			"Cost", "drop type"
["Food",				"Land_Sacks_goods_F",	5000, 	"picnic"],
["Water",				"Land_BarrelWater_F",	5000, 	"picnic"]
];