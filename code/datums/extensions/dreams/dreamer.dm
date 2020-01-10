/datum/extension/dreamer
	base_type = /datum/extension/dreamer
	expected_type = /mob/living
	var/mob/real_self
	var/datum/dream/dream

/datum/extension/dreamer/New(var/holder)

	..()

/datum/extension/dreamer/Destroy()
	real_self = null

	. = ..()

/datum/extension/dreamer/proc/wake_up()

	C.mind.transfer_to()

/datum/extension/dreamer/proc/start_dreaming()
	
	C.mind.transfer_to()

/datum/extension/dreamer/proc/handle_dreams()