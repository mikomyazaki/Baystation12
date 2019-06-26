// Cloaking Control Console

/obj/machinery/computer/ship/cloak
	name = "cloaking control console"
	icon_keyboard = "tech_key"
	icon_screen = "cloak"
	circuit = /obj/item/weapon/stock_parts/circuitboard/cloak
	var/display_state = "status"

/obj/machinery/computer/ship/engines/attack_hand(var/mob/user as mob)
	if(..())
		user.unset_machine()
		return

	if(!isAI(user))
		user.set_machine(src)

	ui_interact(user)

/obj/machinery/computer/ship/engines/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	return 1

/obj/machinery/computer/ship/engines/OnTopic(var/mob/user, var/list/href_list, state)
	return 1