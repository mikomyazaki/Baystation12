/datum/extension/emergent_ai
	base_type = /datum/extension/emergent_ai
	expected_type = /obj/machinery/computer
	var/spread_limit = 3 // number of times this computer can spread to another in range
	var/spread_delay
	var/last_spread = 0
	var/atom/atom_holder
	var/datum/event/emergent_ai/event_holder

	var/strength = 5

/datum/extension/emergent_ai/New(holder, var/datum/event/emergent_ai/event_holder, spread_delay)
	..()
	atom_holder = holder
	event_holder.strength += strength
	event_holder.infected_computers += holder

/datum/extension/emergent_ai/Destroy()
	event_holder.strength -= strength
	event_holder.infected_computers -= holder
	return ..()

/datum/extension/emergent_ai/Process()
	..()
	if(!holder)
		qdel(src)
		return PROCESS_KILL

	if(spread_limit && (world.time - last_spread > spread_delay) && spread())
		spread_limit--
		log_admin("Event [event_holder] event spread to [atom_holder] at [atom_holder.loc.x] [atom_holder.loc.y] [atom_holder.loc.z].")

/datum/extension/emergent_ai/proc/spread()
	var/list/spread_range = range(world.view)
	for(var/obj/machinery/computer/modular/M in spread_range)
		var/datum/extension/interactive/ntos/os = get_extension(M, /datum/extension/interactive/ntos)
		if(os?.on && !has_extension(M, /datum/extension/emergent_ai/modular))
			return !!set_extension(M, /datum/extension/emergent_ai/modular, event_holder, spread_delay)
	for(var/obj/item/modular_computer/M in spread_range)
		var/datum/extension/interactive/ntos/os = get_extension(M, /datum/extension/interactive/ntos)
		if(os?.on && !has_extension(M, /datum/extension/emergent_ai/modular/item))
			return !!set_extension(M, /datum/extension/emergent_ai/modular/item, event_holder, spread_delay)

/datum/extension/emergent_ai/modular
	expected_type = /obj/machinery/computer/modular
	spread_limit = 2
	strength = 1

/datum/extension/emergent_ai/modular/item
	expected_type = /obj/item/modular_computer
	spread_limit = 1
	strength = 1