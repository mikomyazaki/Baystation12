// Submap specific atom definitions.

#define MANTIDIFY(_thing, _name, _desc) \
##_thing/ascent/name = _name; \
##_thing/ascent/desc = "Some kind of strange alien " + _desc + " technology."; \
##_thing/ascent/color = COLOR_PURPLE;

MANTIDIFY(/obj/item/weapon/reagent_containers/food/drinks/cans/waterbottle, "hydration cylinder", "hydration")
MANTIDIFY(/obj/item/weapon/material/knife/kitchen/cleaver, "mantid cleaver", "cleaver")
MANTIDIFY(/obj/machinery/power/apc/hyper, "mantid power node", "power controller")
MANTIDIFY(/obj/structure/reagent_dispensers/water_cooler, "mantid fluid dispenser", "water dispensing")
MANTIDIFY(/obj/machinery/atmospherics/unary/vent_pump/on, "mantid atmosphere outlet", "vent")
MANTIDIFY(/obj/machinery/atmospherics/unary/vent_scrubber/on, "mantid atmosphere intake", "scrubber")
MANTIDIFY(/obj/machinery/hologram/holopad/longrange, "mantid holopad", "holopad")
MANTIDIFY(/obj/machinery/alarm, "mantid thermostat", "atmospherics")
MANTIDIFY(/obj/machinery/optable, "mantid operating table", "operating table")
MANTIDIFY(/obj/machinery/recharge_station, "mantid recharging station", "recharging station")
MANTIDIFY(/obj/machinery/door/airlock/external/bolted, "mantid airlock", "door")
MANTIDIFY(/obj/structure/bed/chair/padded/purple, "mantid nest", "resting place")

#undef MANTIDIFY

/turf/simulated/wall/ascent
	color = COLOR_PURPLE

/turf/simulated/wall/r_wall/ascent
	color = COLOR_PURPLE

/turf/simulated/floor/shuttle_ceiling/ascent
	color = COLOR_PURPLE
	icon_state = "jaggy"
	icon = 'icons/turf/flooring/alium.dmi'

/turf/simulated/floor/ascent
	name = "mantid plating"
	color = COLOR_GRAY20
	initial_gas = list("methyl_bromide" = MOLES_CELLSTANDARD * 0.5, "oxygen" = MOLES_CELLSTANDARD * 0.5)
	icon_state = "curvy"
	icon = 'icons/turf/flooring/alium.dmi'

/turf/simulated/floor/ascent/Initialize()
	. = ..()
	icon_state = "curvy[rand(0,6)]"

/turf/simulated/floor/tiled/ascent
	name = "mantid tiling"
	icon_state = "jaggy"
	icon = 'icons/turf/flooring/alium.dmi'
	color = COLOR_GRAY40
	initial_gas = list("methyl_bromide" = MOLES_CELLSTANDARD * 0.5, "oxygen" = MOLES_CELLSTANDARD * 0.5)
	initial_flooring = /decl/flooring/tiling_ascent

/decl/flooring/tiling_ascent
	name = "floor"
	desc = "An odd jigsaw puzzle of alloy plates."
	icon = 'icons/turf/flooring/alium.dmi'
	icon_base = "jaggy"
	has_base_range = 6
	color = COLOR_GRAY40
	flags = TURF_CAN_BREAK | TURF_CAN_BURN
	footstep_type = FOOTSTEP_TILES

/obj/machinery/portable_atmospherics/hydroponics/ascent
	name = "mantid algae vat"
	desc = "Some kind of strange alien hydroponics technology."
	color = COLOR_PURPLE
	closed_system = TRUE
	construct_state = null

// No maintenance needed.
/obj/machinery/portable_atmospherics/hydroponics/ascent/Process()
	if(dead)
		seed = null
		update_icon()
	if(!seed)
		seed = SSplants.seeds["algae"]
		update_icon()
	waterlevel = 100
	nutrilevel = 10
	pestlevel = 0
	weedlevel = 0
	mutation_level = 0
	health = 100
	sampled = 0
	. = ..()

/obj/machinery/atmospherics/unary/vent_pump/on/ascent
	construct_state = null

/obj/machinery/atmospherics/unary/vent_scrubber/on/ascent
	construct_state = null

/obj/machinery/optable/ascent
	construct_state = null

/obj/machinery/recharge_station/ascent
	construct_state = null

/obj/machinery/body_scanconsole/ascent
	name = "mantid scanner console"
	desc = "Some kind of strange alien console technology."
	req_access = list(access_ascent)
	icon = 'icons/obj/ascent_sleepers.dmi'
	construct_state = null

/obj/machinery/bodyscanner/ascent
	name = "mantid body scanner"
	desc = "Some kind of strange alien body scanning technology."
	icon = 'icons/obj/ascent_sleepers.dmi'
	construct_state = null

/obj/machinery/sleeper/ascent
	name = "mantid sleeper"
	desc = "Some kind of strange alien sleeper technology."
	icon = 'icons/obj/ascent_sleepers.dmi'
	construct_state = null

/obj/structure/bed/chair/padded/purple/ascent
	icon_state = "nest_chair"
	base_icon = "nest_chair"
	pixel_z = 0

/obj/structure/bed/chair/padded/purple/ascent/gyne
	name = "mantid throne"
	icon_state = "nest_chair_large"
	base_icon = "nest_chair_large"

/obj/machinery/autolathe/ascent
	name = "\improper Ascent nanofabricator"
	desc = "A squat, complicated fabrication system clad in purple polymer."
	icon = 'icons/obj/nanofabricator.dmi'
	req_access = list(access_ascent)
	construct_state = null

/obj/machinery/power/apc/hyper/ascent
	req_access = list(access_ascent)
	construct_state = null

/obj/machinery/hologram/holopad/longrange/ascent
	req_access = list(access_ascent)
	construct_state = null

/decl/environment_data/mantid
	important_gasses = list(
		"oxygen" =         TRUE,
		"methyl_bromide" = TRUE,
		"carbon_dioxide" = TRUE,
		"methane" =        TRUE
	)
	dangerous_gasses = list(
		"carbon_dioxide" = TRUE,
		"methane" =        TRUE
	)

/obj/machinery/alarm/ascent
	req_access = list(access_ascent)
	construct_state = null
	environment_type = /decl/environment_data/mantid

/obj/effect/catwalk_plated/ascent
	color = COLOR_GRAY40

/obj/machinery/door/airlock/ascent
	color = COLOR_GRAY40
	desc = "Some kind of strange alien door technology."
	door_color = COLOR_GRAY40
	stripe_color = COLOR_PURPLE
	construct_state = null

/obj/machinery/door/airlock/external/bolted/ascent
	door_color = COLOR_PURPLE
	stripe_color = COLOR_GRAY40
	construct_state = null

/obj/machinery/power/apc/hyper/ascent/north
	name = "north bump"
	pixel_x = 0
	pixel_y = 24
	dir = NORTH
	construct_state = null

/obj/machinery/power/apc/hyper/ascent/south
	name = "south bump"
	pixel_x = 0
	pixel_y = -24
	dir = SOUTH
	construct_state = null

/obj/machinery/power/apc/hyper/ascent/east
	name = "east bump"
	pixel_x = 24
	pixel_y = 0
	dir = EAST
	construct_state = null

/obj/machinery/power/apc/hyper/ascent/west
	name = "west bump"
	pixel_x = -24
	pixel_y = 0
	dir = WEST
	construct_state = null

/obj/machinery/light/ascent
	name = "mantid light"
	light_type = /obj/item/weapon/light/tube/ascent
	desc = "Some kind of strange alien lighting technology."
	construct_state = null

/obj/item/weapon/light/tube/ascent
	name = "mantid light filament"
	color = "#00ffff"
	b_colour = "#00ffff"
	desc = "Some kind of strange alien lightbulb technology."

/obj/machinery/light/ascent/attack_hand()
	return

/obj/machinery/light/ascent/attackby(var/obj/item/thing, var/mob/user)
	if(istype(thing, /obj/item/device/lightreplacer) || (istype(thing, /obj/item/weapon/light) && !istype(thing, /obj/item/weapon/light/tube/ascent)))
		to_chat(user, SPAN_WARNING("It doesn't seem to be compatible with \the [src]."))
		return
	. = ..()

/obj/structure/ascent_spawn
	name = "mantid cryotank"
	desc = "A liquid-filled, cloudy tank with strange forms twitching inside."
	icon = 'icons/obj/cryogenics.dmi'
	icon_state = "cellold2"
	anchored = TRUE
	density =  TRUE

/obj/machinery/computer/ship/helm/ascent
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)
	construct_state = null

/obj/machinery/computer/ship/engines/ascent
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)
	construct_state = null

/obj/machinery/computer/ship/navigation/ascent
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)
	construct_state = null

/obj/machinery/computer/ship/sensors/ascent
	icon_state = "ascent"
	icon_keyboard = "ascent_key"
	icon_screen = "ascent_screen"
	req_access = list(access_ascent)
	construct_state = null
