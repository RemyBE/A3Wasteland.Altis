// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_Convoy.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_convoyVeh", "_veh1", "_createVehicle", "_vehicles", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_box1", "_box2", "_Boxes1", "_Boxes2", "_currBox1", "_currBox2"];

_setupVars =
{
	_missionType = "Ambushers";
	_locationsArray = LandConvoyPaths;

	_reinforceChance = 0; // Chance of reinforcements being called
	_minReinforceGroups = 1; //minimum number of paradrop groups that will respond to call
	_maxReinforceGroups = 3; //maximum number of paradrop groups that will respond to call
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	// pick the vehicles for the convoy
	_convoyVeh = ["I_C_Offroad_02_unarmed_F"];

	_veh1 = _convoyVeh select 0;

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVehicleReportRemoteTargets true;
		_vehicle setVehicleReceiveRemoteTargets true;
		_vehicle setVehicleRadar 1;
		_vehicle confirmSensorTarget [[west,east,resistance], true];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSyndikat;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSyndikatDemo;
		_soldier moveInCargo _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSyndikatLauncher;
		_soldier moveInCargo _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSyndikat;
		_soldier moveInCargo _vehicle;



		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles =
	[
		[_veh1, _starts select 0, _startDirs select 0] call _createVehicle
	];

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh1 >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");

	_missionHintText = format ["Enemy Forces transporting 2 crates to an ambush site. Stop them!", _vehicleName, sideMissionColor];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	_Boxes1 = ["Box_IED_Exp_F","Box_Syndicate_WpsLaunch_F"];
	_currBox1 = _Boxes1 call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1, _lastPos, [], 2, "None"];
	_box1 setDir random 360;
	_box1 allowDamage false;

	_Boxes2 = ["Box_IED_Exp_F","Box_Syndicate_WpsLaunch_F"];
	_currBox2 = _Boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2, _lastPos, [], 2, "None"];
	_box2 setDir random 360;
	_box2 allowDamage false;

	_successHintMessage = "The ambush has been stopped, the weapon crates and vehicles are now yours to take.";
};

_this call sideMissionProcessor;
