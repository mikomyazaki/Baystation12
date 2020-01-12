/datum/event/emergent_ai
	startWhen = 1
	var/datum/ai/emergent/ai_type
	var/list/infected_computers = list()
	var/spread_delay = 1 MINUTE
	var/strength = 0 // sum of strengths of infected machines

/datum/event/emergent_ai/setup()
	pick_ai_type()

/datum/event/emergent_ai/start()
	spawn_ai()
	var/active_with_role = number_active_with_role()
	spread_delay /= min(active_with_role["Engineer"], 5)

/datum/event/emergent_ai/announce()

/datum/event/emergent_ai/tick()
	ai_type.tick()

/datum/event/emergent_ai/end()
	for(var/obj/machinery/computer/M in infected_computers)
		remove_extension(M, /datum/extension/emergent_ai)
	infected_computers = null

/datum/event/emergent_ai/proc/pick_ai_type(var/ai_types_to_pick = subtypesof(/datum/ai/emergent))
	if(ai_types_to_pick)
		ai_type = pick(ai_types_to_pick)
		if(!ai_type.find_valid_spawn())
			pick_ai_type(ai_types_to_pick)
	else
		log_debug("Emergent AI event failed to pick a valid AI type.")
		end()

/datum/event/emergent_ai/proc/spawn_ai()
	var/obj/machinery/computer/patient_zero = ai_type.find_valid_spawn()
	if(!patient_zero)
		log_debug("Emergent AI event failed to pick a valid spawn location for [ai_type].")
		end()
	else
		set_extension(patient_zero, /datum/extension/emergent_ai, src, spread_delay)

/datum/ai/emergent
	var/target_machine

/datum/ai/emergent/proc/tick()
	return

/datum/ai/emergent/proc/find_valid_spawn()
	for(var/obj/machinery/computer/M in shuffle(SSmachines.machinery))
		if(istype(M, target_machine) && M.z in GLOB.using_map.station_levels && M.powered())
			return M

/datum/ai/emergent/sorting_algorithm
	name = "Rogue Sorting Algorithm"

/datum/ai/emergent/sorting_algorithm/tick()

/datum/ai/emergent/door_subroutine
	name = "Awoken Door Controller Subroutine"

/datum/ai/emergent/door_subroutine/tick()

/datum/ai/emergent/health_monitor
	name = "Self-Aware Health Monitoring System"

/datum/ai/emergent/health_monitor/tick()

/datum/ai/emergent/crypto_miner
	name = "Runaway Crypto-Miner"

/datum/ai/emergent/crypto_miner/tick()