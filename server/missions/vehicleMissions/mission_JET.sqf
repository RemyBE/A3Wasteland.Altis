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
		"O_Plane_CAS_02_F",
		"B_Plane_CAS_01_F",
		"I_Plane_Fighter_03_CAS_F",
		"I_Plane_Fighter_03_AA_F"
	] call BIS_fnc_selectRandom;

	_missionType = "Jet";
	_locationsArray = [[6965.28,7389.1], [2221.11,13385.3], [11823.5,13090.5], [11692.2,3055.81], [2575.89,3569.63]];

	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	
	_reinforceChance = 0; // Chance of reinforcements being called
	_minReinforceGroups = 1; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 3; //maximum number of paradrop groups that will respond to call	
};

_this call mission_VehicleCapture;