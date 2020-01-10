/obj/item/device/assembly/signaler
	name = "remote signaling device"
	desc = "Used to remotely activate devices."
	icon_state = "signaller"
	item_state = "signaler"
	origin_tech = list(TECH_MAGNET = 1)
	matter = list(MATERIAL_STEEL = 1000, MATERIAL_GLASS = 200, MATERIAL_WASTE = 100)
	wires = WIRE_RECEIVE | WIRE_PULSE | WIRE_RADIO_PULSE | WIRE_RADIO_RECEIVE

	secured = TRUE

	var/code = 30
	var/frequency = 1457
	var/delay = 0
	var/airlock_wire = null
	var/datum/wires/connected = null
	var/datum/radio_frequency/radio_connection
	var/deadman = 0

/obj/item/device/assembly/signaler/New()
	..()
	addtimer(CALLBACK(src, .proc/set_frequency, frequency), 4 SECONDS, TIMER_UNIQUE)

/obj/item/device/assembly/signaler/activate()
	if(cooldown)
		return FALSE
	start_cooldown()

	signal()
	return TRUE

/obj/item/device/assembly/signaler/on_update_icon()
	if(holder)
		holder.update_icon()
	return

/obj/item/device/assembly/signaler/interact(var/mob/user, flag1)
	var/t1 = "-------"
	var/dat = {"
		<TT>

		<A href='byond://?src=\ref[src];send=1'>Send Signal</A><BR>
		<B>Frequency/Code</B> for signaler:<BR>
		Frequency:
		<A href='byond://?src=\ref[src];freq=-10'>-</A>
		<A href='byond://?src=\ref[src];freq=-2'>-</A>
		[format_frequency(src.frequency)]
		<A href='byond://?src=\ref[src];freq=2'>+</A>
		<A href='byond://?src=\ref[src];freq=10'>+</A><BR>

		Code:
		<A href='byond://?src=\ref[src];code=-5'>-</A>
		<A href='byond://?src=\ref[src];code=-1'>-</A>
		[src.code]
		<A href='byond://?src=\ref[src];code=1'>+</A>
		<A href='byond://?src=\ref[src];code=5'>+</A><BR>
		[t1]
		</TT>"}
	user << browse(dat, "window=radio")
	onclose(user, "radio")

/obj/item/device/assembly/signaler/Topic(href, href_list, state = GLOB.physical_state)
	if((. = ..()))
		usr << browse(null, "window=radio")
		onclose(usr, "radio")
		return

	if (href_list["freq"])
		var/new_frequency = (frequency + text2num(href_list["freq"]))
		if(new_frequency < RADIO_LOW_FREQ || new_frequency > RADIO_HIGH_FREQ)
			new_frequency = sanitize_frequency(new_frequency, RADIO_LOW_FREQ, RADIO_HIGH_FREQ)
		set_frequency(new_frequency)

	if(href_list["code"])
		src.code += text2num(href_list["code"])
		src.code = round(src.code)
		src.code = min(100, src.code)
		src.code = max(1, src.code)

	if(href_list["send"])
		addtimer(CALLBACK(src, .proc/signal)

	if(usr)
		attack_self(usr)

/obj/item/device/assembly/signaler/proc/signal()
	if(!radio_connection)
		return

	var/datum/signal/signal = new
	signal.source = src
	signal.encryption = code
	signal.data["message"] = "ACTIVATE"
	radio_connection.post_signal(src, signal)

/obj/item/device/assembly/signaler/pulse(var/radio = 0)
	if(src.connected && src.wires)
		connected.Pulse(src)
	else if(holder)
		holder.process_activation(src, 1, 0)
	else
		..(radio)
	return TRUE

/obj/item/device/assembly/signaler/receive_signal(datum/signal/signal)
	if(!signal)	
		return FALSE
	if(signal.encryption != code)
		return FALSE
	if(!(src.wires & WIRE_RADIO_RECEIVE))
		return FALSE
	pulse(1)

	if(!holder)
		for(var/mob/O in hearers(1, src.loc))
			O.show_message(text("\icon[] *beep* *beep*", src), 3, "*beep* *beep*", 2)

/obj/item/device/assembly/signaler/proc/set_frequency(new_frequency)
	set waitfor = 0
	if(!frequency)
		return
	if(!radio_controller)
		sleep(20)
	if(!radio_controller)
		return
	radio_controller.remove_object(src, frequency)
	frequency = new_frequency
	radio_connection = radio_controller.add_object(src, frequency, RADIO_CHAT)

/obj/item/device/assembly/signaler/Process()
	if(!deadman)
		STOP_PROCESSING(SSobj, src)
	var/mob/M = src.loc
	if(!M || !ismob(M))
		if(prob(5))
			signal()
		deadman = FALSE
		STOP_PROCESSING(SSobj, src)
	else if(prob(5))
		M.visible_message("[M]'s finger twitches a bit over [src]'s signal button!")
	return

/obj/item/device/assembly/signaler/verb/deadman_it()
	set src in usr
	set name = "Threaten to push the button!"
	set desc = "BOOOOM!"

	if(!deadman)
		deadman = TRUE
		START_PROCESSING(SSobj, src)
		log_and_message_admins("is threatening to trigger a signaler deadman's switch")
		usr.visible_message(SPAN_DANGER("[usr] moves their finger over [src]'s signal button..."))
	else
		deadman = FALSE
		STOP_PROCESSING(SSobj, src)
		log_and_message_admins("stops threatening to trigger a signaler deadman's switch")
		usr.visible_message(SPAN_NOTICE("[usr] moves their finger away from [src]'s signal button."))


/obj/item/device/assembly/signaler/Destroy()
	if(radio_controller)
		radio_controller.remove_object(src,frequency)
	frequency = 0
	. = ..()