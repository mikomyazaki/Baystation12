/datum/extension/holographic
	expected_type = /atom
	var/holographic = TRUE
	flags = EXTENSION_FLAG_IMMEDIATE
	var/holo_alpha = 0.8

/datum/extension/holographic/New(var/atom/holder)
	..()
	holder.alpha *= holo_alpha
	makeContentsHolographic(holder)

/datum/extension/holographic/proc/makeContentsHolographic(var/atom/item)
	for(var/atom/held_item in item.contents && !istype(held_item,/obj/effect/landmark))
		set_extension(held_item,/datum/extension/holographic,/datum/extension/holographic)

/datum/extension/holographic/Destroy(var/atom/holder)
	if(ismob(holder))
		var/mob/M = holder
		M.death(null, "fades away!", "You have been destroyed.")
	if(holder)
		holder.alpha /= holo_alpha
	. = ..()

/datum/extension/holographic/proc/checkHolographicContents(var/atom/item) //recursively check for holographic items within containers and delete them, or non-holographic items within holographic containers and drop them.
	if(item)
		for(var/obj/held_item in item.contents)
			if(has_extension(held_item,/datum/extension/holographic,/datum/extension/holographic/movable))
				if(held_item.contents)
					checkHolographicContents(held_item)
				qdel(held_item)
			else
				held_item.dropInto(held_item.locs[1])

/datum/extension/holographic/proc/ValidTarget(var/atom/A)
	..()
	var/turf/T = get_turf(A)
	if(!has_extension(T,/datum/extension/holographic))
		return FALSE

/datum/extension/holographic/movable
	expected_type = /atom/movable

/datum/extension/holographic/movable/New(var/atom/holder)
	..()
	GLOB.moved_event.register(holder, src, .proc/OnMovement)

/datum/extension/holographic/movable/Destroy(var/atom/holder)
	GLOB.moved_event.unregister(holder, src, .proc/OnMovement)
	. = ..()

/datum/extension/holographic/movable/proc/OnMovement(var/atom/mover, var/old_location, var/new_location)
	if(get_area(old_location) != get_area(new_location))
		if(mover?.contents)
			checkHolographicContents(mover)
		qdel(mover)