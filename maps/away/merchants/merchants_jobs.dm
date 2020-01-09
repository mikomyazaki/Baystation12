/datum/job/submap/merchants/captain
	title = "Merchant-Captain"
	total_positions = 1
	supervisors = "the next opportunity for profit"
	info = "You are the Captain of an independent merchant vessel. Fortune has brought you to this untapped sector, full of riches and potenial. Stake your claim, find new customers and make as much money as you can."
	outfit_type = /decl/hierarchy/outfit/job/merchants/captain
	loadout_allowed = TRUE
	min_skill = list(SKILL_EVA = SKILL_ADEPT,
					SKILL_PILOT = SKILL_ADEPT,
					SKILL_HAULING = SKILL_ADEPT,
					SKILL_COMBAT = SKILL_ADEPT,
					SKILL_WEAPONS = SKILL_ADEPT,
					SKILL_SCIENCE = SKILL_ADEPT,
					SKILL_MEDICAL = SKILL_BASIC)

/datum/job/submap/merchants/pilot
	title = "Independent Pilot"
	total_positions = 1
	supervisors = "the Merchant-Captain"
	info = "You are a pilot hired to fly a small merchant vessel wherever its Captain may desire, in the pursuit of profit."
	outfit_type = /decl/hierarchy/outfit/job/merchants/engineer

/datum/job/submap/merchants/engineer
	title = "Independent Engineer"
	total_positions = 1
	supervisors = "the Merchant-Captain"
	info = "You are an hired to maintain a small merchant vessel through whatever trials may befall it."
	outfit_type = /decl/hierarchy/outfit/job/merchants/engineer

/datum/job/submap/merchants/doctor
	title = "Independent Doctor"
	total_positions = 1
	supervisors = "the Merchant-Captain"
	info = "You are an hired to care for the health of the crew."
	outfit_type = /decl/hierarchy/outfit/job/merchants/engineer

/datum/job/submap/merchants/crewman
	title = "Independent Crewman"
	total_positions = 3
	supervisors = "the Merchant-Captain"
	info = "You have been hired by an independent merchant to do whatever odd-jobs or duties aboard their ship they might need."
	outfit_type = /decl/hierarchy/outfit/job/merchants/crewman
	alt_titles = list(
		"Bodyguard",
		"Cook",
		"Salesman"
	)

/datum/job/submap/merchants/passenger
	title = "Passenger"
	total_positions = 3
	supervisors = "the Merchant-Captain, the Pilot, the Engineer and Crewmen"
	info = "A Merchant-Captain has rented you a cabin on-board his vessel, keep out of the Crew's way and keep yourself entertained while it takes you to your destination."
	alt_titles = list(
		"Diplomat",
		"Tourist",
		"Researcher",
		"Missionary"
	)