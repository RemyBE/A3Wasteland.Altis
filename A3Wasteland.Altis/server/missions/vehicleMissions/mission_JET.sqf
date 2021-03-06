// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_ArmedHeli.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "vehicleMissionDefines.sqf";

private ["_vehicleClass", "_nbUnits"];

_setupVars =
{
	_vehicleClass =
	[
		"B_Plane_CAS_01_F",
		"O_Plane_CAS_02_F",
		"I_Plane_Fighter_03_CAS_F",
		"I_Plane_Fighter_03_AA_F",
		"I_Plane_Fighter_04_F",
	        "O_Plane_Fighter_02_F",
	        "O_Plane_Fighter_02_Stealth_F",
	        "B_Plane_Fighter_01_F",
	        "B_Plane_Fighter_01_Stealth_F"
	
	] call BIS_fnc_selectRandom;

	_missionType = "Jet";
	_locationsArray = JetSpawnMarkers;

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	
	_reinforceChance = 0; // Chance of reinforcements being called
	_minReinforceGroups = 1; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 3; //maximum number of paradrop groups that will respond to call	
};

_this call mission_VehicleCapture;
