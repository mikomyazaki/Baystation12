var/list/ship_cloaks = list()
/datum/ship_cloak
	var/name = "ship cloak generator"
	var/obj/machinery/holder	//actual engine object


/datum/ship_cloak/proc/toggle()
	return 1

/datum/ship_cloak/proc/is_on()
	return 1

/datum/ship_cloak/proc/status()
	return "All systems nominal."

/datum/ship_cloak/proc/set_cloak_strength()
	return 1

/datum/ship_cloak/proc/destroy()
	. = ..()
	ship_cloak -= src
	var/obj/effect/overmap/ship/S = map_sectors["[holder.z]"]
	if(istype(S))
		S.cloaks -= src
	holder = null