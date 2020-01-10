/datum/dream
	var/datum/map_template/dream/dream_map
	var/mob/living/carbon/dreamer

/datum/dream/New(var/holder, var/nightmare)
	dream_map = pick(SSmapping.dream_map_templates)

/datum/map_template/dream
	var/list/active_dreamers = list()