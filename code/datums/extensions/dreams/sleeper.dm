/datum/extension/sleeper
	base_type = /datum/extension/sleeper
	expected_type = /mob/living/carbon
	var/mob/dream_self
	var/datum/dream/dream
	var/nightmare = FALSE

/datum/extension/sleeper/New(var/holder)
	setup_dream()

	..()

/datum/extension/sleeper/Destroy()
	real_self = null
	QDEL_NULL(dream_self)

	. = ..()

/datum/extension/sleeper/proc/setup_dream()
	nightmare = pick(TRUE,FALSE)
	dream = new /datum/dream(holder, nightmare)

/datum/extension/sleeper/proc/wake_up()
	C.mind.transfer_to(holder)
	QDEL_NULL(dream)

	remove_extension(holder, src)

/datum/extension/sleeper/proc/start_dreaming()
	C.mind.transfer_to(dream_self)

/datum/extension/sleeper/proc/handle_dreams()

/datum/extension/sleeper/proc/get_sleeping_state()
	var/mob/living/carbon/C = holder
	if(nightmare)
		. = SPAN_WARNING("[C.He] appears to be sleeping fitfully, struggling against unseen horrors.\n")
	else
		. = "[C.His] eyes are moving rapidly behind [C.his] eyelids.\n"