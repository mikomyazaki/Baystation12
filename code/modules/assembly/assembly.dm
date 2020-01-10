/obj/item/device/assembly
	name = "assembly"
	desc = "A small electronic device that should never exist."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = ""
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_STEEL = 100)
	throwforce = 2
	throw_speed = 3
	throw_range = 10
	origin_tech = list(TECH_MAGNET = 1)

	var/secured = TRUE
	var/list/attached_overlays = null
	var/obj/item/device/assembly_holder/holder = null
	var/cooldown = FALSE
	var/wires = WIRE_RECEIVE | WIRE_PULSE

	var/cooldown_time = 2 SECONDS

	var/const/WIRE_RECEIVE = 1			//Allows Pulsed(0) to call Activate()
	var/const/WIRE_PULSE = 2				//Allows Pulse(0) to act on the holder
	var/const/WIRE_PULSE_SPECIAL = 4		//Allows Pulse(0) to act on the holders special assembly
	var/const/WIRE_RADIO_RECEIVE = 8		//Allows Pulsed(1) to call Activate()
	var/const/WIRE_RADIO_PULSE = 16		//Allows Pulse(1) to send a radio message

/obj/item/device/assembly/proc/activate()									//What the device does when turned on
	if(!secured || cooldown)
		return FALSE
	start_cooldown()
	return TRUE

/obj/item/device/assembly/proc/start_cooldown()
	cooldown = TRUE
	addtimer(CALLBACK(src, .proc/end_cooldown), cooldown_time, TIMER_UNIQUE)

/obj/item/device/assembly/proc/pulsed(var/radio = 0)						//Called when another assembly acts on this one, var/radio will determine where it came from for wire calcs
	if(holder && (wires & WIRE_RECEIVE))
		activate()
	if(radio && (wires & WIRE_RADIO_RECEIVE))
		activate()
	return TRUE

/obj/item/device/assembly/proc/pulse(var/radio = 0)						//Called when this device attempts to act on another device, var/radio determines if it was sent via radio or direct
	if(holder && (wires & WIRE_PULSE))
		holder.process_activation(src, 1, 0)
	if(holder && (wires & WIRE_PULSE_SPECIAL))
		holder.process_activation(src, 0, 1)
//		if(radio && (wires & WIRE_RADIO_PULSE))
		//Not sure what goes here quite yet send signal?
	return TRUE

/obj/item/device/assembly/proc/toggle_secure()								//Code that has to happen when the assembly is un\secured goes here
	secured = !secured
	update_icon()
	return secured

/obj/item/device/assembly/proc/attach_assembly(var/obj/A, var/mob/user)	//Called when an assembly is attacked by another
	holder = new/obj/item/device/assembly_holder(get_turf(src))
	if(holder.attach(A,src,user))
		to_chat(user, SPAN_NOTICE("You attach \the [A] to \the [src]!"))
		return TRUE

/obj/item/device/assembly/proc/end_cooldown()
	cooldown = FALSE													//Called via a timer to finish the cooldown of an assembly

/obj/item/device/assembly/proc/holder_movement()							//Called when the holder is moved
	return

/obj/item/device/assembly/interact(var/mob/user)					//Called when attack_self is called
	return

/obj/item/device/assembly/attackby(var/obj/item/weapon/W, var/mob/user)
	if(isassembly(W))
		var/obj/item/device/assembly/A = W
		if((!A.secured) && (!secured))
			attach_assembly(A,user)
			return
	if(isScrewdriver(W))
		if(toggle_secure())
			to_chat(user, SPAN_NOTICE("\The [src] is ready!"))
		else
			to_chat(user, SPAN_NOTICE("\The [src] can now be attached!"))
		return
	..()

/obj/item/device/assembly/Process()
	return PROCESS_KILL

/obj/item/device/assembly/examine(var/mob/user, var/distance)
	. = ..()
	if(distance <= 1 || loc == user)
		if(secured)
			to_chat(user, "\The [src] is ready!")
		else
			to_chat(user, "\The [src] can be attached!")

/obj/item/device/assembly/attack_self(var/mob/user)
	if(user)
		user.set_machine(src)
		interact(user)
		return TRUE

/obj/item/device/assembly/nano_host()
	if(istype(loc, /obj/item/device/assembly_holder))
		return loc.nano_host()
	return ..()