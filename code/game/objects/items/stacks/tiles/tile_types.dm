/obj/item/stack/tile
	name = "broken tile"
	singular_name = "broken tile"
	desc = "A broken tile. This should not exist."
	lefthand_file = 'icons/mob/inhands/misc/tiles_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/tiles_righthand.dmi'
	icon = 'icons/obj/tiles.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	force = 1
	throwforce = 1
	throw_speed = 3
	throw_range = 7
	max_amount = 60
	novariants = TRUE
	/// What type of turf does this tile produce.
	var/turf_type = null
	/// What dir will the turf have?
	var/turf_dir = SOUTH
	/// Cached associative lazy list to hold the radial options for tile reskinning. See tile_reskinning.dm for more information. Pattern: list[type] -> image
	var/list/tile_reskin_types
	/// Cached associative lazy list to hold the radial options for tile dirs. See tile_reskinning.dm for more information.
	var/list/tile_rotate_dirs

/obj/item/stack/tile/Initialize(mapload, new_amount, merge = TRUE, list/mat_override=null, mat_amt=1)
	. = ..()
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3) //randomize a little
	if(tile_reskin_types)
		tile_reskin_types = tile_reskin_list(tile_reskin_types)
	if(tile_rotate_dirs)
		var/list/values = list()
		for(var/set_dir in tile_rotate_dirs)
			values += dir2text(set_dir)
		tile_rotate_dirs = tile_dir_list(values, turf_type)


/obj/item/stack/tile/examine(mob/user)
	. = ..()
	if(tile_reskin_types || tile_rotate_dirs)
		. += SPAN_NOTICE("Use while in your hand to change what type of [src] you want.")
	if(throwforce && !is_cyborg) //do not want to divide by zero or show the message to borgs who can't throw
		var/verb
		switch(CEILING(MAX_LIVING_HEALTH / throwforce, 1)) //throws to crit a human
			if(1 to 3)
				verb = "superb"
			if(4 to 6)
				verb = "great"
			if(7 to 9)
				verb = "good"
			if(10 to 12)
				verb = "fairly decent"
			if(13 to 15)
				verb = "mediocre"
		if(!verb)
			return
		. += SPAN_NOTICE("Those could work as a [verb] throwing weapon.")


/obj/item/stack/tile/proc/place_tile(turf/open/T)
	if(!turf_type || !use(1))
		return
	var/turf/placed_turf = T.PlaceOnTop(turf_type, flags = CHANGETURF_INHERIT_AIR)
	placed_turf.setDir(turf_dir)
	return placed_turf

//Grass
/obj/item/stack/tile/grass
	name = "grass tile"
	singular_name = "grass floor tile"
	desc = "A patch of grass like they use on space golf courses."
	icon_state = "tile_grass"
	inhand_icon_state = "tile-grass"
	turf_type = /turf/open/floor/grass
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/grass

//Fairygrass
/obj/item/stack/tile/fairygrass
	name = "fairygrass tile"
	singular_name = "fairygrass floor tile"
	desc = "A patch of odd, glowing blue grass."
	icon_state = "tile_fairygrass"
	inhand_icon_state = "tile-fairygrass"
	turf_type = /turf/open/floor/grass/fairy
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fairygrass

//Wood
/obj/item/stack/tile/wood
	name = "wood floor tile"
	singular_name = "wood floor tile"
	desc = "An easy to fit wood floor tile. Use while in your hand to change what pattern you want."
	icon_state = "tile-wood"
	inhand_icon_state = "tile-wood"
	turf_type = /turf/open/floor/wood
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/wood
	tile_reskin_types = list(
		/obj/item/stack/tile/wood,
		/obj/item/stack/tile/wood/large,
		/obj/item/stack/tile/wood/tile,
		/obj/item/stack/tile/wood/parquet,
	)

/obj/item/stack/tile/wood/parquet
	name = "parquet wood floor tile"
	singular_name = "parquet wood floor tile"
	icon_state = "tile-wood_parquet"
	turf_type = /turf/open/floor/wood/parquet
	merge_type = /obj/item/stack/tile/wood/parquet

/obj/item/stack/tile/wood/large
	name = "large wood floor tile"
	singular_name = "large wood floor tile"
	icon_state = "tile-wood_large"
	turf_type = /turf/open/floor/wood/large
	merge_type = /obj/item/stack/tile/wood/large

/obj/item/stack/tile/wood/tile
	name = "tiled wood floor tile"
	singular_name = "tiled wood floor tile"
	icon_state = "tile-wood_tile"
	turf_type = /turf/open/floor/wood/tile
	merge_type = /obj/item/stack/tile/wood/tile

//Basalt
/obj/item/stack/tile/basalt
	name = "basalt tile"
	singular_name = "basalt floor tile"
	desc = "Artificially made ashy soil themed on a hostile environment."
	icon_state = "tile_basalt"
	inhand_icon_state = "tile-basalt"
	turf_type = /turf/open/floor/grass/fakebasalt
	merge_type = /obj/item/stack/tile/basalt

//Carpets
/obj/item/stack/tile/carpet
	name = "carpet"
	singular_name = "carpet tile"
	desc = "A piece of carpet. It is the same size as a floor tile."
	icon_state = "tile-carpet"
	inhand_icon_state = "tile-carpet"
	turf_type = /turf/open/floor/carpet
	resistance_flags = FLAMMABLE
	tableVariant = /obj/structure/table/wood/fancy
	merge_type = /obj/item/stack/tile/carpet
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet,
		/obj/item/stack/tile/carpet/symbol,
		/obj/item/stack/tile/carpet/star,
	)

/obj/item/stack/tile/carpet/symbol
	name = "symbol carpet"
	singular_name = "symbol carpet tile"
	icon_state = "tile-carpet-symbol"
	desc = "A piece of carpet. This one has a symbol on it."
	turf_type = /turf/open/floor/carpet/lone
	merge_type = /obj/item/stack/tile/carpet/symbol
	tile_rotate_dirs = list(SOUTH, NORTH, EAST, WEST, SOUTHEAST)

/obj/item/stack/tile/carpet/star
	name = "star carpet"
	singular_name = "star carpet tile"
	icon_state = "tile-carpet-star"
	desc = "A piece of carpet. This one has a star on it."
	turf_type = /turf/open/floor/carpet/lone/star
	merge_type = /obj/item/stack/tile/carpet/star

/obj/item/stack/tile/carpet/black
	name = "black carpet"
	icon_state = "tile-carpet-black"
	inhand_icon_state = "tile-carpet-black"
	turf_type = /turf/open/floor/carpet/black
	tableVariant = /obj/structure/table/wood/fancy/black
	merge_type = /obj/item/stack/tile/carpet/black

/obj/item/stack/tile/carpet/blue
	name = "blue carpet"
	icon_state = "tile-carpet-blue"
	inhand_icon_state = "tile-carpet-blue"
	turf_type = /turf/open/floor/carpet/blue
	tableVariant = /obj/structure/table/wood/fancy/blue
	merge_type = /obj/item/stack/tile/carpet/blue

/obj/item/stack/tile/carpet/cyan
	name = "cyan carpet"
	icon_state = "tile-carpet-cyan"
	inhand_icon_state = "tile-carpet-cyan"
	turf_type = /turf/open/floor/carpet/cyan
	tableVariant = /obj/structure/table/wood/fancy/cyan
	merge_type = /obj/item/stack/tile/carpet/cyan

/obj/item/stack/tile/carpet/green
	name = "green carpet"
	icon_state = "tile-carpet-green"
	inhand_icon_state = "tile-carpet-green"
	turf_type = /turf/open/floor/carpet/green
	tableVariant = /obj/structure/table/wood/fancy/green
	merge_type = /obj/item/stack/tile/carpet/green

/obj/item/stack/tile/carpet/orange
	name = "orange carpet"
	icon_state = "tile-carpet-orange"
	inhand_icon_state = "tile-carpet-orange"
	turf_type = /turf/open/floor/carpet/orange
	tableVariant = /obj/structure/table/wood/fancy/orange
	merge_type = /obj/item/stack/tile/carpet/orange

/obj/item/stack/tile/carpet/purple
	name = "purple carpet"
	icon_state = "tile-carpet-purple"
	inhand_icon_state = "tile-carpet-purple"
	turf_type = /turf/open/floor/carpet/purple
	tableVariant = /obj/structure/table/wood/fancy/purple
	merge_type = /obj/item/stack/tile/carpet/purple

/obj/item/stack/tile/carpet/red
	name = "red carpet"
	icon_state = "tile-carpet-red"
	inhand_icon_state = "tile-carpet-red"
	turf_type = /turf/open/floor/carpet/red
	tableVariant = /obj/structure/table/wood/fancy/red
	merge_type = /obj/item/stack/tile/carpet/red

/obj/item/stack/tile/carpet/royalblack
	name = "royal black carpet"
	icon_state = "tile-carpet-royalblack"
	inhand_icon_state = "tile-carpet-royalblack"
	turf_type = /turf/open/floor/carpet/royalblack
	tableVariant = /obj/structure/table/wood/fancy/royalblack
	merge_type = /obj/item/stack/tile/carpet/royalblack

/obj/item/stack/tile/carpet/royalblue
	name = "royal blue carpet"
	icon_state = "tile-carpet-royalblue"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/royalblue
	tableVariant = /obj/structure/table/wood/fancy/royalblue
	merge_type = /obj/item/stack/tile/carpet/royalblue

/obj/item/stack/tile/carpet/executive
	name = "executive carpet"
	icon_state = "tile_carpet_executive"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/executive
	merge_type = /obj/item/stack/tile/carpet/executive

/obj/item/stack/tile/carpet/stellar
	name = "stellar carpet"
	icon_state = "tile_carpet_stellar"
	inhand_icon_state = "tile-carpet-royalblue"
	turf_type = /turf/open/floor/carpet/stellar
	merge_type = /obj/item/stack/tile/carpet/stellar

/obj/item/stack/tile/carpet/donk
	name = "\improper Donk Co. promotional carpet"
	icon_state = "tile_carpet_donk"
	inhand_icon_state = "tile-carpet-orange"
	turf_type = /turf/open/floor/carpet/donk
	merge_type = /obj/item/stack/tile/carpet/donk

/obj/item/stack/tile/carpet/fifty
	amount = 50

/obj/item/stack/tile/carpet/black/fifty
	amount = 50

/obj/item/stack/tile/carpet/blue/fifty
	amount = 50

/obj/item/stack/tile/carpet/cyan/fifty
	amount = 50

/obj/item/stack/tile/carpet/green/fifty
	amount = 50

/obj/item/stack/tile/carpet/orange/fifty
	amount = 50

/obj/item/stack/tile/carpet/purple/fifty
	amount = 50

/obj/item/stack/tile/carpet/red/fifty
	amount = 50

/obj/item/stack/tile/carpet/royalblack/fifty
	amount = 50

/obj/item/stack/tile/carpet/royalblue/fifty
	amount = 50

/obj/item/stack/tile/carpet/executive/thirty
	amount = 30

/obj/item/stack/tile/carpet/stellar/thirty
	amount = 30

/obj/item/stack/tile/carpet/donk/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon
	name = "neon carpet"
	singular_name = "neon carpet tile"
	desc = "A piece of rubbery mat inset with a phosphorescent pattern."
	inhand_icon_state = "tile-neon"
	turf_type = /turf/open/floor/carpet/neon
	merge_type = /obj/item/stack/tile/carpet/neon

	// Neon overlay
	/// The icon used for the neon overlay and emissive overlay.
	var/neon_icon
	/// The icon state used for the neon overlay and emissive overlay.
	var/neon_icon_state
	/// The icon state used for the neon overlay inhands.
	var/neon_inhand_icon_state
	/// The color used for the neon overlay.
	var/neon_color
	/// The alpha used for the emissive overlay.
	var/emissive_alpha = 150

/obj/item/stack/tile/carpet/neon/update_overlays()
	. = ..()
	var/mutable_appearance/neon_overlay = mutable_appearance(neon_icon || icon, neon_icon_state || icon_state, alpha = alpha)
	neon_overlay.color = neon_color
	. += neon_overlay
	. += emissive_appearance(neon_icon || icon, neon_icon_state || icon_state, alpha = emissive_alpha)

/obj/item/stack/tile/carpet/neon/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands || !neon_inhand_icon_state)
		return

	var/mutable_appearance/neon_overlay = mutable_appearance(icon_file, neon_inhand_icon_state)
	neon_overlay.color = neon_color
	. += neon_overlay
	. += emissive_appearance(icon_file, neon_inhand_icon_state, alpha = emissive_alpha, appearance_flags = KEEP_APART)

/obj/item/stack/tile/carpet/neon/simple
	name = "simple neon carpet"
	singular_name = "simple neon carpet tile"
	icon_state = "tile_carpet_neon_simple"
	neon_icon_state = "tile_carpet_neon_simple_light"
	neon_inhand_icon_state = "tile-neon-glow"
	turf_type = /turf/open/floor/carpet/neon/simple
	merge_type = /obj/item/stack/tile/carpet/neon/simple
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple,
		/obj/item/stack/tile/carpet/neon/simple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	neon_inhand_icon_state = "tile-neon-glow-nodots"
	turf_type = /turf/open/floor/carpet/neon/simple
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple,
		/obj/item/stack/tile/carpet/neon/simple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/white
	name = "simple white neon carpet"
	singular_name = "simple white neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/white
	merge_type = /obj/item/stack/tile/carpet/neon/simple/white
	neon_color = COLOR_WHITE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/white,
		/obj/item/stack/tile/carpet/neon/simple/white/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/white/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/white/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/white/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/white,
		/obj/item/stack/tile/carpet/neon/simple/white/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/black
	name = "simple black neon carpet"
	singular_name = "simple black neon carpet tile"
	neon_icon_state = "tile_carpet_neon_simple_glow"
	turf_type = /turf/open/floor/carpet/neon/simple/black
	merge_type = /obj/item/stack/tile/carpet/neon/simple/black
	neon_color = COLOR_BLACK
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/black,
		/obj/item/stack/tile/carpet/neon/simple/black/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/black/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_glow_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/black/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/black/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/black,
		/obj/item/stack/tile/carpet/neon/simple/black/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/red
	name = "simple red neon carpet"
	singular_name = "simple red neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/red
	merge_type = /obj/item/stack/tile/carpet/neon/simple/red
	neon_color = COLOR_RED
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/red,
		/obj/item/stack/tile/carpet/neon/simple/red/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/red/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/red/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/red/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/red,
		/obj/item/stack/tile/carpet/neon/simple/red/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/orange
	name = "simple orange neon carpet"
	singular_name = "simple orange neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/orange
	merge_type = /obj/item/stack/tile/carpet/neon/simple/orange
	neon_color = COLOR_ORANGE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/orange,
		/obj/item/stack/tile/carpet/neon/simple/orange/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/orange/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/orange/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/orange/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/orange,
		/obj/item/stack/tile/carpet/neon/simple/orange/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/yellow
	name = "simple yellow neon carpet"
	singular_name = "simple yellow neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/yellow
	merge_type = /obj/item/stack/tile/carpet/neon/simple/yellow
	neon_color = COLOR_YELLOW
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/yellow,
		/obj/item/stack/tile/carpet/neon/simple/yellow/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/yellow/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/yellow/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/yellow,
		/obj/item/stack/tile/carpet/neon/simple/yellow/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/lime
	name = "simple lime neon carpet"
	singular_name = "simple lime neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/lime
	merge_type = /obj/item/stack/tile/carpet/neon/simple/lime
	neon_color = COLOR_LIME
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/lime,
		/obj/item/stack/tile/carpet/neon/simple/lime/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/lime/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/lime/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/lime/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/lime,
		/obj/item/stack/tile/carpet/neon/simple/lime/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/green
	name = "simple green neon carpet"
	singular_name = "simple green neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/green
	merge_type = /obj/item/stack/tile/carpet/neon/simple/green
	neon_color = COLOR_GREEN
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/green,
		/obj/item/stack/tile/carpet/neon/simple/green/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/green/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/green/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/green/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/green,
		/obj/item/stack/tile/carpet/neon/simple/green/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/teal
	name = "simple teal neon carpet"
	singular_name = "simple teal neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/teal
	merge_type = /obj/item/stack/tile/carpet/neon/simple/teal
	neon_color = COLOR_TEAL
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/teal,
		/obj/item/stack/tile/carpet/neon/simple/teal/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/teal/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/teal/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/teal/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/teal,
		/obj/item/stack/tile/carpet/neon/simple/teal/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/cyan
	name = "simple cyan neon carpet"
	singular_name = "simple cyan neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/cyan
	merge_type = /obj/item/stack/tile/carpet/neon/simple/cyan
	neon_color = COLOR_CYAN
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/cyan,
		/obj/item/stack/tile/carpet/neon/simple/cyan/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/cyan/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/cyan/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/cyan,
		/obj/item/stack/tile/carpet/neon/simple/cyan/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/blue
	name = "simple blue neon carpet"
	singular_name = "simple blue neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/blue
	merge_type = /obj/item/stack/tile/carpet/neon/simple/blue
	neon_color = COLOR_BLUE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/blue,
		/obj/item/stack/tile/carpet/neon/simple/blue/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/blue/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/blue/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/blue/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/blue,
		/obj/item/stack/tile/carpet/neon/simple/blue/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/purple
	name = "simple purple neon carpet"
	singular_name = "simple purple neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/purple
	merge_type = /obj/item/stack/tile/carpet/neon/simple/purple
	neon_color = COLOR_PURPLE
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/purple,
		/obj/item/stack/tile/carpet/neon/simple/purple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/purple/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/purple/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/purple/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/purple,
		/obj/item/stack/tile/carpet/neon/simple/purple/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/violet
	name = "simple violet neon carpet"
	singular_name = "simple violet neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/violet
	merge_type = /obj/item/stack/tile/carpet/neon/simple/violet
	neon_color = COLOR_VIOLET
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/violet,
		/obj/item/stack/tile/carpet/neon/simple/violet/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/violet/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/violet/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/violet/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/violet,
		/obj/item/stack/tile/carpet/neon/simple/violet/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/pink
	name = "simple pink neon carpet"
	singular_name = "simple pink neon carpet tile"
	turf_type = /turf/open/floor/carpet/neon/simple/pink
	merge_type = /obj/item/stack/tile/carpet/neon/simple/pink
	neon_color = COLOR_LIGHT_PINK
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/pink,
		/obj/item/stack/tile/carpet/neon/simple/pink/nodots,
	)

/obj/item/stack/tile/carpet/neon/simple/pink/nodots
	icon_state = "tile_carpet_neon_simple_nodots"
	neon_icon_state = "tile_carpet_neon_simple_light_nodots"
	turf_type = /turf/open/floor/carpet/neon/simple/pink/nodots
	merge_type = /obj/item/stack/tile/carpet/neon/simple/pink/nodots
	tile_reskin_types = list(
		/obj/item/stack/tile/carpet/neon/simple/pink,
		/obj/item/stack/tile/carpet/neon/simple/pink/nodots,
	)

/obj/item/stack/tile/carpet/neon/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/white/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/white/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/white/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/black/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/black/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/black/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/red/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/red/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/red/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/orange/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/orange/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/orange/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/yellow/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/yellow/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/yellow/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/lime/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/lime/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/lime/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/green/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/green/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/green/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/teal/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/teal/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/teal/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/cyan/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/cyan/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/cyan/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/blue/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/blue/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/blue/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/purple/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/purple/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/purple/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/violet/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/violet/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/violet/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/pink/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/pink/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/pink/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/white/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/white/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/white/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/black/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/black/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/black/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/red/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/red/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/red/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/orange/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/orange/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/orange/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/yellow/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/lime/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/lime/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/lime/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/green/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/green/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/green/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/teal/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/teal/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/teal/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/cyan/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/blue/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/blue/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/blue/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/purple/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/purple/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/purple/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/violet/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/violet/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/violet/nodots/sixty
	amount = 60

/obj/item/stack/tile/carpet/neon/simple/pink/nodots/ten
	amount = 10

/obj/item/stack/tile/carpet/neon/simple/pink/nodots/thirty
	amount = 30

/obj/item/stack/tile/carpet/neon/simple/pink/nodots/sixty
	amount = 60

/obj/item/stack/tile/fakespace
	name = "astral carpet"
	singular_name = "astral carpet tile"
	desc = "A piece of carpet with a convincing star pattern."
	icon_state = "tile_space"
	inhand_icon_state = "tile-space"
	turf_type = /turf/open/floor/fakespace
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakespace

/obj/item/stack/tile/fakespace/loaded
	amount = 30

/obj/item/stack/tile/fakepit
	name = "fake pits"
	singular_name = "fake pit"
	desc = "A piece of carpet with a forced perspective illusion of a pit. No way this could fool anyone!"
	icon_state = "tile_pit"
	inhand_icon_state = "tile-basalt"
	turf_type = /turf/open/floor/fakepit
	resistance_flags = FLAMMABLE
	merge_type = /obj/item/stack/tile/fakepit

/obj/item/stack/tile/fakepit/loaded
	amount = 30

//High-traction
/obj/item/stack/tile/noslip
	name = "high-traction floor tile"
	singular_name = "high-traction floor tile"
	desc = "A high-traction floor tile. It feels rubbery in your hand."
	icon_state = "tile_noslip"
	inhand_icon_state = "tile-noslip"
	turf_type = /turf/open/floor/noslip
	merge_type = /obj/item/stack/tile/noslip

/obj/item/stack/tile/noslip/thirty
	amount = 30

//Circuit
/obj/item/stack/tile/circuit
	name = "blue circuit tile"
	singular_name = "blue circuit tile"
	desc = "A blue circuit tile."
	icon_state = "tile_bcircuit"
	inhand_icon_state = "tile-bcircuit"
	turf_type = /turf/open/floor/circuit
	merge_type = /obj/item/stack/tile/circuit

/obj/item/stack/tile/circuit/green
	name = "green circuit tile"
	singular_name = "green circuit tile"
	desc = "A green circuit tile."
	icon_state = "tile_gcircuit"
	inhand_icon_state = "tile-gcircuit"
	turf_type = /turf/open/floor/circuit/green
	merge_type = /obj/item/stack/tile/circuit/green

/obj/item/stack/tile/circuit/green/anim
	turf_type = /turf/open/floor/circuit/green/anim
	merge_type = /obj/item/stack/tile/circuit/green/anim

/obj/item/stack/tile/circuit/red
	name = "red circuit tile"
	singular_name = "red circuit tile"
	desc = "A red circuit tile."
	icon_state = "tile_rcircuit"
	inhand_icon_state = "tile-rcircuit"
	turf_type = /turf/open/floor/circuit/red
	merge_type = /obj/item/stack/tile/circuit/red

/obj/item/stack/tile/circuit/red/anim
	turf_type = /turf/open/floor/circuit/red/anim
	merge_type = /obj/item/stack/tile/circuit/red/anim

//Pod floor
/obj/item/stack/tile/pod
	name = "pod floor tile"
	singular_name = "pod floor tile"
	desc = "A grooved floor tile."
	icon_state = "tile_pod"
	inhand_icon_state = "tile-pod"
	turf_type = /turf/open/floor/pod
	merge_type = /obj/item/stack/tile/pod
	tile_reskin_types = list(
		/obj/item/stack/tile/pod,
		/obj/item/stack/tile/pod/light,
		/obj/item/stack/tile/pod/dark,
		)

/obj/item/stack/tile/pod/light
	name = "light pod floor tile"
	singular_name = "light pod floor tile"
	desc = "A lightly colored grooved floor tile."
	icon_state = "tile_podlight"
	turf_type = /turf/open/floor/pod/light
	merge_type = /obj/item/stack/tile/pod/light

/obj/item/stack/tile/pod/dark
	name = "dark pod floor tile"
	singular_name = "dark pod floor tile"
	desc = "A darkly colored grooved floor tile."
	icon_state = "tile_poddark"
	turf_type = /turf/open/floor/pod/dark
	merge_type = /obj/item/stack/tile/pod/dark

/obj/item/stack/tile/plastic
	name = "plastic tile"
	singular_name = "plastic floor tile"
	desc = "A tile of cheap, flimsy plastic flooring."
	icon_state = "tile_plastic"
	mats_per_unit = list(/datum/material/plastic=500)
	turf_type = /turf/open/floor/plastic
	merge_type = /obj/item/stack/tile/plastic

/obj/item/stack/tile/material
	name = "floor tile"
	singular_name = "floor tile"
	desc = "The ground you walk on."
	throwforce = 10
	icon_state = "material_tile"
	turf_type = /turf/open/floor/material
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	merge_type = /obj/item/stack/tile/material

/obj/item/stack/tile/material/place_tile(turf/open/T)
	. = ..()
	var/turf/open/floor/material/F = .
	F?.set_custom_materials(mats_per_unit)

/obj/item/stack/tile/eighties
	name = "retro tile"
	singular_name = "retro floor tile"
	desc = "A stack of floor tiles that remind you of an age of funk. Use in your hand to pick between a black or red pattern."
	icon_state = "tile_eighties"
	turf_type = /turf/open/floor/eighties
	merge_type = /obj/item/stack/tile/eighties
	tile_reskin_types = list(
		/obj/item/stack/tile/eighties,
		/obj/item/stack/tile/eighties/red,
	)

/obj/item/stack/tile/eighties/loaded
	amount = 15

/obj/item/stack/tile/eighties/red
	name = "red retro tile"
	singular_name = "red retro floor tile"
	desc = "A stack of REDICAL floor tiles! Use in your hand to pick between a black or red pattern!" //i am so sorry
	icon_state = "tile_eightiesred"
	turf_type = /turf/open/floor/eighties/red
	merge_type = /obj/item/stack/tile/eighties/red

/obj/item/stack/tile/bronze
	name = "bronze tile"
	singular_name = "bronze floor tile"
	desc = "A clangy tile made of high-quality bronze. Clockwork construction techniques allow the clanging to be minimized."
	icon_state = "tile_brass"
	turf_type = /turf/open/floor/bronze
	mats_per_unit = list(/datum/material/bronze=500)
	merge_type = /obj/item/stack/tile/bronze
	tile_reskin_types = list(
		/obj/item/stack/tile/bronze,
		/obj/item/stack/tile/bronze/flat,
		/obj/item/stack/tile/bronze/filled,
		)

/obj/item/stack/tile/bronze/flat
	name = "flat bronze tile"
	singular_name = "flat bronze floor tile"
	icon_state = "tile_reebe"
	turf_type = /turf/open/floor/bronze/flat
	merge_type = /obj/item/stack/tile/bronze/flat

/obj/item/stack/tile/bronze/filled
	name = "filled bronze tile"
	singular_name = "filled bronze floor tile"
	icon_state = "tile_brass_filled"
	turf_type = /turf/open/floor/bronze/filled
	merge_type = /obj/item/stack/tile/bronze/filled

/obj/item/stack/tile/cult
	name = "engraved tile"
	singular_name = "engraved floor tile"
	desc = "A strange tile made from runed metal. Doesn't seem to actually have any paranormal powers."
	icon_state = "tile_cult"
	turf_type = /turf/open/floor/cult
	mats_per_unit = list(/datum/material/runedmetal=500)
	merge_type = /obj/item/stack/tile/cult

/// Floor tiles used to test emissive turfs.
/obj/item/stack/tile/emissive_test
	name = "emissive test tile"
	singular_name = "emissive test floor tile"
	desc = "A glow-in-the-dark floor tile used to test emissive turfs."
	turf_type = /turf/open/floor/emissive_test
	merge_type = /obj/item/stack/tile/emissive_test

/obj/item/stack/tile/emissive_test/update_overlays()
	. = ..()
	. += emissive_appearance(icon, icon_state, alpha = alpha)

/obj/item/stack/tile/emissive_test/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	. += emissive_appearance(standing.icon, standing.icon_state, alpha = standing.alpha, appearance_flags = KEEP_APART)

/obj/item/stack/tile/emissive_test/sixty
	amount = 60

/obj/item/stack/tile/emissive_test/white
	name = "white emissive test tile"
	singular_name = "white emissive test floor tile"
	turf_type = /turf/open/floor/emissive_test/white
	merge_type = /obj/item/stack/tile/emissive_test/white

/obj/item/stack/tile/emissive_test/white/sixty
	amount = 60
